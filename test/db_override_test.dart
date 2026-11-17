import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/core/database/app_database.dart';
import 'package:meterwise/core/database/database_provider.dart';
import 'package:meterwise/features/tenants/data/tenant_repository.dart';

void main() {
  test('override identity + direct query', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);

    expect(identical(container.read(appDatabaseProvider), db), isTrue);

    // Direct (non-stream) read.
    final direct = await container.read(tenantRepositoryProvider).getAll();
    expect(direct, isEmpty);
  });
}
