import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';

part 'database_provider.g.dart';

/// Exposes the singleton [AppDatabase] to the Riverpod graph.
///
/// `keepAlive` because the database lives for the whole app session; it is
/// disposed only when the provider container is torn down. Repositories read
/// the database through this provider, never by constructing `AppDatabase()`
/// directly — this keeps a single connection and makes test overrides trivial.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}
