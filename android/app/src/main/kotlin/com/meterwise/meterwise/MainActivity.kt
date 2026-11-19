package com.meterwise.meterwise

import android.annotation.SuppressLint
import android.os.CancellationSignal
import android.os.ParcelFileDescriptor
import android.print.MeterWisePrintCallbacks
import android.print.PageRange
import android.print.PrintAttributes
import android.print.PrintDocumentAdapter
import android.util.Log
import android.view.ViewGroup
import android.webkit.WebView
import android.webkit.WebViewClient
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.meterwise.app/invoice_pdf"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "htmlToPdf" -> {
                        val html = call.argument<String>("html")
                        val path = call.argument<String>("path")
                        val title = call.argument<String>("title")
                        if (html == null || path == null) {
                            result.error("INVALID_ARGS", "html and path are required", null)
                        } else {
                            convert(html, path, title ?: "MeterWise Invoice", result)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Renders HTML to a PDF using an owned WebView and the platform print
     * adapter. The view is kept alive for the whole job and torn down after —
     * unlike the plugin, nothing can hang on a dangling WebView reference.
     *
     * The job runs WebView/print work on the UI thread; only the calling
     * (background) thread waits on latches, so the main thread never blocks.
     */
    private fun convert(html: String, path: String, title: String, result: MethodChannel.Result) {
        // MethodChannel handlers are invoked on the platform (main) thread.
        // Waiting on the print latches there would freeze the whole app, so the
        // job runs on its own thread; WebView work is posted back to the UI
        // thread by PdfJob, and cleanup is posted there too.
        Thread {
            Log.d("MWPDF", "convert start, html=${html.length} chars, path=$path")
            val job = PdfJob(html, path, title)
            try {
                job.start()
                if (!job.awaitLayout(20)) job.fail("print layout timed out")
                if (job.failure == null) {
                    job.beginWrite()
                    if (!job.awaitWrite(20)) job.fail("print write timed out")
                }
                val error = job.failure
                val size = if (error == null) runCatching { File(path).length() }.getOrDefault(0) else 0
                Log.d("MWPDF", "job done: error=$error size=$size")
                // Do not rewrite the WebView PDF. A hand-built trailer without
                // a matching xref table makes strict viewers reject the file.
                when {
                    error != null -> result.error("PDF_FAILED", error, null)
                    size <= 500 -> result.error("PDF_FAILED", "PDF too small ($size bytes)", null)
                    else -> result.success(path)
                }
            } catch (t: Throwable) {
                Log.e("MWPDF", "convert threw", t)
                result.error("PDF_FAILED", t.message ?: "unknown error", null)
            } finally {
                job.cleanup()
            }
        }.apply { name = "MeterWise-PDF" }.start()
    }

    @SuppressLint("SetJavaScriptEnabled")
    private inner class PdfJob(
        private val html: String,
        private val path: String,
        private val title: String,
    ) {
        private val layoutLatch = CountDownLatch(1)
        private val writeLatch = CountDownLatch(1)
        private val attributes = PrintAttributes.Builder()
            .setMediaSize(PrintAttributes.MediaSize.ISO_A4)
            .setMinMargins(PrintAttributes.Margins.NO_MARGINS)
            .setResolution(PrintAttributes.Resolution("default", "300dpi", 300, 300))
            .build()

        @Volatile
        var failure: String? = null
            private set

        private var adapter: PrintDocumentAdapter? = null
        private var webView: WebView? = null
        private var host: ViewGroup? = null

        fun start() {
            runOnUiThread {
                try {
                    val wv = WebView(this@MainActivity)
                    webView = wv
                    wv.settings.javaScriptEnabled = false
                    wv.settings.allowFileAccess = false
                    wv.settings.allowContentAccess = false
                    wv.settings.domStorageEnabled = false
                    wv.settings.loadWithOverviewMode = true

                    // WebView needs a real size to lay out pages. Keep it
                    // attached but transparent so the user never sees it.
                    val frame = android.widget.FrameLayout(this@MainActivity)
                    frame.alpha = 0f
                    frame.isFocusable = false
                    frame.isClickable = false
                    wv.isFocusable = false
                    wv.isClickable = false
                    host = frame
                    addContentView(
                        frame,
                        ViewGroup.LayoutParams(
                            ViewGroup.LayoutParams.MATCH_PARENT,
                            ViewGroup.LayoutParams.MATCH_PARENT
                        )
                    )
                    frame.addView(
                        wv,
                        ViewGroup.LayoutParams(
                            ViewGroup.LayoutParams.MATCH_PARENT,
                            ViewGroup.LayoutParams.MATCH_PARENT
                        )
                    )

                    wv.webViewClient = object : WebViewClient() {
                        override fun onPageFinished(view: WebView?, url: String?) {
                            Log.d("MWPDF", "onPageFinished")
                            beginLayout(wv)
                        }
                    }
                    Log.d("MWPDF", "loading html into WebView")
                    wv.loadDataWithBaseURL(null, html, "text/html", "utf-8", null)
                } catch (t: Throwable) {
                    fail(t.message ?: "WebView setup failed")
                }
            }
        }

        private fun beginLayout(wv: WebView) {
            try {
                val printAdapter = wv.createPrintDocumentAdapter(title)
                adapter = printAdapter
                Log.d("MWPDF", "onLayout started")
                printAdapter.onLayout(
                    null,
                    attributes,
                    CancellationSignal(),
                    MeterWisePrintCallbacks.layout(layoutLatch) { message -> fail(message) },
                    null
                )
            } catch (t: Throwable) {
                fail(t.message ?: "print layout threw")
            }
        }

        fun beginWrite() {
            runOnUiThread {
                val printAdapter = adapter
                if (printAdapter == null) {
                    fail("print adapter missing")
                    return@runOnUiThread
                }
                try {
                    val output = ParcelFileDescriptor.open(
                        File(path),
                        ParcelFileDescriptor.MODE_CREATE or
                            ParcelFileDescriptor.MODE_READ_WRITE or
                            ParcelFileDescriptor.MODE_TRUNCATE
                    )
                    printAdapter.onWrite(
                        arrayOf(PageRange.ALL_PAGES),
                        output,
                        CancellationSignal(),
                        MeterWisePrintCallbacks.write(writeLatch) { message -> fail(message) }
                    )
                } catch (t: Throwable) {
                    fail(t.message ?: "print write threw")
                }
            }
        }

        fun awaitLayout(seconds: Long): Boolean =
            layoutLatch.await(seconds, TimeUnit.SECONDS)

        fun awaitWrite(seconds: Long): Boolean =
            writeLatch.await(seconds, TimeUnit.SECONDS)

        fun fail(message: String) {
            Log.w("MWPDF", "fail: $message")
            if (failure == null) failure = message
            layoutLatch.countDown()
            writeLatch.countDown()
        }

        fun cleanup() {
            runOnUiThread {
                try {
                    host?.let { (it.parent as? ViewGroup)?.removeView(it) }
                    webView?.destroy()
                } catch (_: Throwable) {
                } finally {
                    adapter = null
                    webView = null
                    host = null
                }
            }
        }
    }
}
