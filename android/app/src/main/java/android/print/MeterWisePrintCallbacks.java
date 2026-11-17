package android.print;

import java.util.concurrent.CountDownLatch;

/**
 * Bridges the package-private constructors of the platform print callbacks.
 *
 * Android's SDK stubs declare these constructors package-private, so Kotlin
 * (and Java outside this package) cannot subclass them. Declaring the bridge
 * in {@code android.print} lets us create real callbacks for WebView printing.
 */
public final class MeterWisePrintCallbacks {
    public interface OnFail {
        void fail(String message);
    }

    private MeterWisePrintCallbacks() {}

    public static PrintDocumentAdapter.LayoutResultCallback layout(
            CountDownLatch done, OnFail onFail) {
        return new PrintDocumentAdapter.LayoutResultCallback() {
            @Override
            public void onLayoutFinished(PrintDocumentInfo info, boolean changed) {
                done.countDown();
            }

            @Override
            public void onLayoutFailed(CharSequence error) {
                onFail.fail(error == null ? "print layout failed" : error.toString());
            }

            @Override
            public void onLayoutCancelled() {
                onFail.fail("print layout cancelled");
            }
        };
    }

    public static PrintDocumentAdapter.WriteResultCallback write(
            CountDownLatch done, OnFail onFail) {
        return new PrintDocumentAdapter.WriteResultCallback() {
            @Override
            public void onWriteFinished(PageRange[] pages) {
                done.countDown();
            }

            @Override
            public void onWriteFailed(CharSequence error) {
                onFail.fail(error == null ? "print write failed" : error.toString());
            }

            @Override
            public void onWriteCancelled() {
                onFail.fail("print write cancelled");
            }
        };
    }
}
