import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import '../../../core/database/app_database.dart';
import 'drive_config.dart';
import 'packet_crypto.dart';

/// Google Drive transport for meter packets.
///
/// Each user signs in with their own Google account. The landlord uploads a
/// `landlord.json` packet into `MeterWise/<meter code>/`; the tenant downloads
/// it and imports it into their local SQLite. No MeterWise server is involved.
class DriveSyncService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  GoogleSignInAccount? _account;
  bool _initialized = false;

  Future<drive.DriveApi> _api() async {
    if (!_initialized) {
      await _googleSignIn.initialize(
        clientId: driveClientId.isEmpty ? null : driveClientId,
        serverClientId:
            driveServerClientId.isEmpty ? null : driveServerClientId,
      );
      _initialized = true;
    }
    _account ??= await _googleSignIn.attemptLightweightAuthentication() ??
        await _googleSignIn.authenticate(scopeHint: driveScopes);
    final authorization =
        await _account!.authorizationClient.authorizeScopes(driveScopes);
    final credentials = AccessCredentials(
      AccessToken(
        'Bearer',
        authorization.accessToken,
        DateTime.now().toUtc().add(const Duration(hours: 1)),
      ),
      null,
      driveScopes,
    );
    return drive.DriveApi(authenticatedClient(http.Client(), credentials));
  }

  Future<String> signInEmail() async {
    await _api();
    return _account!.email;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _account = null;
  }

  Future<String> _folder(drive.DriveApi api, String name, String? parent) async {
    final q = "name='$name' and mimeType='application/vnd.google-apps.folder' "
        'and trashed=false and ${parent == null ? "'root' in parents" : "'$parent' in parents"}';
    final existing = await api.files.list(q: q, $fields: 'files(id)');
    if (existing.files?.isNotEmpty ?? false) return existing.files!.first.id!;
    final created = await api.files.create(drive.File(
      name: name,
      mimeType: 'application/vnd.google-apps.folder',
      parents: parent == null ? const ['root'] : [parent],
    ));
    return created.id!;
  }

  Future<String> _meterFolder(drive.DriveApi api, String meterCode) async {
    final root = await _folder(api, 'MeterWise', null);
    return _folder(api, meterCode, root);
  }

  Future<String> _readText(drive.DriveApi api, String fileId) async {
    final media = await api.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;
    final chunks = await media.stream.toList();
    return utf8.decode(chunks.expand((c) => c).toList(growable: false));
  }

  Future<void> _writeFile(
    drive.DriveApi api,
    String folderId,
    String name,
    String content,
  ) async {
    final bytes = utf8.encode(content);
    final media = drive.Media(Stream.value(bytes), bytes.length);
    final existing = await api.files.list(
      q: "name='$name' and '$folderId' in parents and trashed=false",
      $fields: 'files(id)',
    );
    if (existing.files?.isNotEmpty ?? false) {
      await api.files.update(
        drive.File(),
        existing.files!.first.id!,
        uploadMedia: media,
      );
    } else {
      await api.files.create(
        drive.File(name: name, parents: [folderId]),
        uploadMedia: media,
      );
    }
  }

  /// Landlord: upload the encrypted packet, replacing any previous version.
  Future<void> uploadPacket({
    required String meterCode,
    required Map<String, dynamic> packet,
  }) async {
    final api = await _api();
    final folderId = await _meterFolder(api, meterCode);
    await _writeFile(
      api,
      folderId,
      'landlord.enc',
      PacketCrypto.encrypt(meterCode, packet),
    );
  }

  /// Tenant: download and decrypt the landlord's packet.
  Future<Map<String, dynamic>?> downloadPacket(String meterCode) async {
    final api = await _api();
    final folderId = await _meterFolder(api, meterCode);
    final found = await api.files.list(
      q: "name='landlord.enc' and '$folderId' in parents and trashed=false",
      $fields: 'files(id)',
    );
    if (found.files?.isEmpty ?? true) return null;
    final text = await _readText(api, found.files!.first.id!);
    return PacketCrypto.decrypt(meterCode, text);
  }

  /// Tenant: write their own entries back so the landlord can pick them up.
  Future<void> uploadTenantPacket({
    required String meterCode,
    required String tenantName,
    required Map<String, dynamic> packet,
  }) async {
    final api = await _api();
    final folderId = await _meterFolder(api, meterCode);
    final safe = tenantName.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
    await _writeFile(
      api,
      folderId,
      'tenant_$safe.enc',
      PacketCrypto.encrypt(meterCode, packet),
    );
  }

  /// Landlord: download every tenant write-back packet.
  Future<List<Map<String, dynamic>>> downloadTenantPackets(
    String meterCode,
  ) async {
    final api = await _api();
    final folderId = await _meterFolder(api, meterCode);
    final found = await api.files.list(
      q: "'$folderId' in parents and trashed=false and "
          "name contains 'tenant_' and name contains '.enc'",
      $fields: 'files(id,name)',
    );
    final result = <Map<String, dynamic>>[];
    for (final file in found.files ?? const <drive.File>[]) {
      try {
        final text = await _readText(api, file.id!);
        result.add(PacketCrypto.decrypt(meterCode, text));
      } on Object {
        // Skip packets encrypted with a different meter code.
      }
    }
    return result;
  }

  /// Tenant packet: only that tenant's own entries.
  Map<String, dynamic> buildTenantPacket({
    required String tenantName,
    required List<MeterReading> readings,
    required List<Recharge> recharges,
  }) =>
      {
        'version': 1,
        'kind': 'tenant',
        'tenantName': tenantName,
        'generatedAt': DateTime.now().toIso8601String(),
        'readings': [
          for (final r in readings)
            {
              'date': r.readingDate.toIso8601String(),
              'value': r.readingValue,
            }
        ],
        'recharges': [
          for (final r in recharges)
            {
              'date': r.rechargeDate.toIso8601String(),
              'amount': r.amount,
              'agentFee': r.agentFee,
              'otherExpenses': r.otherExpenses,
              'paidByTenantId': r.paidByTenantId,
            }
        ],
      };

  /// Builds the packet from local data. Kept here so both roles use one shape.
  Map<String, dynamic> buildPacket({
    required String meterCode,
    required String propertyName,
    required String? propertyAddress,
    required String currency,
    required String providerName,
    required List<Tenant> tenants,
    required List<MeterReading> readings,
    required List<Recharge> recharges,
    AppSetting? approval,
  }) =>
      {
        'version': 1,
        'meterCode': meterCode,
        'tenantApproval': approval == null
            ? null
            : {'tenantId': approval.tenantId, 'approved': approval.tenantApproved},
        'generatedAt': DateTime.now().toIso8601String(),
        'property': {
          'name': propertyName,
          'address': propertyAddress,
          'currency': currency,
          'provider': providerName,
        },
        'tenants': [
          for (final t in tenants)
            {
              'id': t.id,
              'name': t.name,
              'phone': t.phone,
              'billingMode': t.billingMode,
              'fixedRate': t.fixedRate,
            }
        ],
        'readings': [
          for (final r in readings)
            {
              'mainMeterId': r.mainMeterId,
              'tenantId': r.tenantId,
              'date': r.readingDate.toIso8601String(),
              'value': r.readingValue,
            }
        ],
        'recharges': [
          for (final r in recharges)
            {
              'date': r.rechargeDate.toIso8601String(),
              'amount': r.amount,
              'paidBy': r.paidBy,
              'paidByTenantId': r.paidByTenantId,
              'agentFee': r.agentFee,
              'otherExpenses': r.otherExpenses,
            }
        ],
      };
}
