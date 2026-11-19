import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Dart side of the Android channel that owns a WebView to render HTML→PDF.
///
/// The platform code keeps a strong reference to the WebView for the lifetime
/// of the job and reports explicit success/failure, so this call cannot hang
/// the way `Printing.convertHtml` can. Returns null on any failure; callers
/// fall back to the plugin, then to the English vector renderer.
class NativeInvoicePdf {
  const NativeInvoicePdf._();

  static const MethodChannel _channel =
      MethodChannel('com.meterwise.app/invoice_pdf');

  /// A WebView can write an empty or HTML error page to the .pdf path. Validate
  /// the header and trailer so we never share a file a viewer calls "invalid".
  static bool _looksLikePdf(Uint8List bytes) {
    if (bytes.length < 500) return false;
    final header = String.fromCharCodes(bytes.sublist(0, 5));
    final tail = String.fromCharCodes(
        bytes.sublist(bytes.length - 1024 > 0 ? bytes.length - 1024 : 0));
    return header == '%PDF-' && tail.contains('%%EOF');
  }

  static Future<Uint8List?> convert(String html, {String? title}) async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/invoice_${DateTime.now().microsecondsSinceEpoch}.pdf';
    try {
      final written =
          await _channel.invokeMethod<String>('htmlToPdf', <String, Object?>{
        'html': html,
        'path': path,
        'title': title ?? 'MeterWise Invoice',
      });
      if (written == null) return null;
      final file = File(written);
      if (!await file.exists()) return null;
      final bytes = await file.readAsBytes();
      await file.delete();
      return _looksLikePdf(bytes) ? bytes : null;
    } on PlatformException {
      return null;
    } finally {
      // Clean up even if reading/deleting failed.
      final stale = File(path);
      if (await stale.exists()) {
        try {
          await stale.delete();
        } on Object {
          // best effort
        }
      }
    }
  }
}
