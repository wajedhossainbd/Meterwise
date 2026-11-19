import 'package:workmanager/workmanager.dart';

import '../../../core/database/app_database.dart';
import '../../settings/data/settings_repository.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../readings/data/reading_repository.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import 'drive_sync_service.dart';
import 'packet_import_service.dart';

const String meterSyncTask = 'com.meterwise.sync.hourly';

@pragma('vm:entry-point')
void syncCallbackDispatcher() {
  Workmanager().executeTask((task, input) async {
    if (task != meterSyncTask) return true;
    try {
      final db = AppDatabase();
      final settings = SettingsRepository(db);
      final config = await settings.get();
      final code = await settings.ensureMeterCode();
      final drive = DriveSyncService();
      final importer = PacketImportService(db);

      if (config.appRole == 'tenant') {
        final used = config.joinedMeterCode ?? code;
        final packet = await drive.downloadPacket(used);
        if (packet != null) await importer.import(packet);
      } else {
        final property = await PropertyRepository(db).getFirst();
        final meterRepo = MainMeterRepository(db);
        final packet = drive.buildPacket(
          meterCode: code,
          propertyName: property?.name ?? 'MeterWise',
          propertyAddress: property?.address,
          currency: property?.currencyCode ?? 'BDT',
          providerName: await meterRepo.providerName() ?? 'DPDC',
          tenants: await TenantRepository(db).getAll(),
          readings: await ReadingRepository(db).getAll(),
          recharges: await RechargeRepository(db).getAll(),
          approval: await SettingsRepository(db).get(),
        );
        await drive.uploadPacket(meterCode: code, packet: packet);
        for (final tenantPacket
            in await drive.downloadTenantPackets(code)) {
          await importer.importTenantPacket(tenantPacket);
        }
      }
      await db.close();
      return true;
    } on Object {
      // A background failure must not loop forever; the next hour retries.
      return false;
    }
  });
}
