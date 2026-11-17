import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Picks an image from the camera or gallery and copies it into the app's
/// private documents directory, returning the stored path.
///
/// Kept offline-first: images live under `<docs>/images/` so they're included
/// in local backups and can later be synced.
class ImageStorage {
  ImageStorage._();

  static final ImagePicker _picker = ImagePicker();

  static Future<Directory> _imagesDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'images'));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }

  /// Returns the stored local path, or null if the user cancelled.
  static Future<String?> pick(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (picked == null) return null;

    final dir = await _imagesDir();
    final name =
        '${DateTime.now().millisecondsSinceEpoch}_${p.basename(picked.path)}';
    final dest = File(p.join(dir.path, name));
    await File(picked.path).copy(dest.path);
    return dest.path;
  }
}
