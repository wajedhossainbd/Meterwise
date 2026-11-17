import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/connection/database_connection.dart';

/// Local, offline backup & restore of the database and attached images.
///
/// A backup is a single `.zip` containing the SQLite database plus the
/// `images/` folder (receipts + meter photos). Restore stages the database for
/// an atomic swap on next launch (see [openConnection]) and restores images
/// immediately. Google Drive sync can later wrap [createBackup]/[restoreFrom].
class BackupService {
  /// Builds a backup zip in a temporary location and returns the file.
  Future<File> createBackup() async {
    final docs = await getApplicationDocumentsDirectory();
    final tmp = await getTemporaryDirectory();

    final stamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .split('.')
        .first;
    final outPath = p.join(tmp.path, 'meterwise_backup_$stamp.zip');

    final encoder = ZipFileEncoder()..create(outPath);
    final dbFile = File(p.join(docs.path, AppConstants.databaseFileName));
    if (dbFile.existsSync()) {
      await encoder.addFile(dbFile, AppConstants.databaseFileName);
    }
    final imagesDir = Directory(p.join(docs.path, 'images'));
    if (imagesDir.existsSync()) {
      await encoder.addDirectory(imagesDir);
    }
    await encoder.close();
    return File(outPath);
  }

  /// Restores from [zip]: images are written immediately; the database is staged
  /// for an atomic swap on the next app launch. Returns true on success.
  ///
  /// The caller should prompt the user to restart the app afterwards.
  Future<bool> restoreFrom(File zip) async {
    final docs = await getApplicationDocumentsDirectory();
    final bytes = await zip.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    var foundDb = false;
    for (final entry in archive) {
      if (!entry.isFile) continue;
      final name = p.basename(entry.name);
      final data = entry.readBytes();
      if (data == null) continue;

      if (name == AppConstants.databaseFileName &&
          !entry.name.contains('images/')) {
        // Stage the database; the live file is replaced on next open.
        final staged = File(p.join(docs.path, stagedRestoreFileName));
        await staged.writeAsBytes(data, flush: true);
        foundDb = true;
      } else if (entry.name.contains('images/')) {
        final out = File(p.join(docs.path, 'images', name));
        out.parent.createSync(recursive: true);
        await out.writeAsBytes(data, flush: true);
      }
    }
    return foundDb;
  }
}

final backupServiceProvider =
    Provider<BackupService>((ref) => BackupService());
