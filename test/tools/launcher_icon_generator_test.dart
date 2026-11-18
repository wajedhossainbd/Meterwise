import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Generates the Android launcher icons (legacy mipmaps + adaptive-icon
/// foregrounds) so the app icon matches the in-app splash logo: a solid
/// brand-blue disc with a white lightning bolt.
///
/// Runs as part of `flutter test`; output is deterministic and idempotent.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const res = 'android/app/src/main/res';
  const legacySizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192,
  };
  const foregroundSizes = {
    'mipmap-mdpi': 108,
    'mipmap-hdpi': 162,
    'mipmap-xhdpi': 216,
    'mipmap-xxhdpi': 324,
    'mipmap-xxxhdpi': 432,
  };

  test('generate launcher icons matching the splash logo', () async {
    for (final e in legacySizes.entries) {
      final png = await _drawIcon(e.value, foreground: false);
      final f = File('$res/${e.key}/ic_launcher.png');
      f.parent.createSync(recursive: true);
      f.writeAsBytesSync(png);
    }
    for (final e in foregroundSizes.entries) {
      final png = await _drawIcon(e.value, foreground: true);
      File('$res/${e.key}/ic_launcher_foreground.png').writeAsBytesSync(png);
    }

    File('$res/mipmap-anydpi-v26/ic_launcher.xml')
      ..parent.createSync(recursive: true)
      ..writeAsStringSync('''
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''');
    File('$res/values/ic_launcher_background.xml')
      ..parent.createSync(recursive: true)
      ..writeAsStringSync('''
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#2962FF</color>
</resources>
''');

    expect(File('$res/mipmap-xxxhdpi/ic_launcher.png').lengthSync(),
        greaterThan(500));
  });
}

/// Lightning-bolt polygon in a unit box (matches the splash's bolt shape).
const _bolt = [
  Offset(0.585, 0.06),
  Offset(0.315, 0.545),
  Offset(0.475, 0.545),
  Offset(0.425, 0.94),
  Offset(0.70, 0.45),
  Offset(0.535, 0.45),
];

Future<Uint8List> _drawIcon(int size, {required bool foreground}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final s = size.toDouble();

  if (!foreground) {
    // Flat brand disc (legacy icon) — no gradient, no glow.
    final paint = Paint()
      ..isAntiAlias = true
      ..color = const Color(0xFF2962FF);
    canvas.drawCircle(Offset(s / 2, s / 2), s / 2 * 0.98, paint);
  }

  // White bolt: 55% of the canvas on the legacy disc; 34% for the adaptive
  // foreground (must sit inside the 66% safe zone of the 108dp canvas).
  final boltBox = s * (foreground ? 0.34 : 0.55);
  final o = Offset((s - boltBox) / 2, (s - boltBox) / 2);
  final path = Path()
    ..moveTo(o.dx + _bolt.first.dx * boltBox, o.dy + _bolt.first.dy * boltBox);
  for (final p in _bolt.skip(1)) {
    path.lineTo(o.dx + p.dx * boltBox, o.dy + p.dy * boltBox);
  }
  path.close();
  canvas.drawPath(path, Paint()..color = Colors.white..isAntiAlias = true);

  final image = await recorder.endRecording().toImage(size, size);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return bytes!.buffer.asUint8List();
}
