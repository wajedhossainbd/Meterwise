import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../constants/app_constants.dart';

/// File name of a staged database awaiting restore (see backup_service.dart).
const String stagedRestoreFileName = 'restore.sqlite';

/// Opens the on-device SQLite database lazily, on a background isolate.
///
/// If a staged restore file exists (placed by the backup/restore flow), it is
/// swapped in *before* the database is opened — the only safe moment to replace
/// the file, since nothing holds it open yet.
LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, AppConstants.databaseFileName));

    final staged = File(p.join(dir.path, stagedRestoreFileName));
    if (staged.existsSync()) {
      await staged.copy(file.path);
      await staged.delete();
    }

    return NativeDatabase.createInBackground(file);
  });
}
