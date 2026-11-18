import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import 'drive_sync_service.dart';
import 'packet_import_service.dart';

final driveSyncProvider = Provider<DriveSyncService>(
  (ref) => DriveSyncService(),
);

final packetImportProvider = Provider<PacketImportService>(
  (ref) => PacketImportService(ref.watch(appDatabaseProvider)),
);
