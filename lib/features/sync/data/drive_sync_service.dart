import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import '../../../core/database/app_database.dart';
import 'drive_config.dart';

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
      );
      _initialized = true;
    }
    _account ??= await _googleSignIn.attemptLightweightAuthentication() ??
        await _googleSignIn.authenticate(scopeHint: driveScopes);
    final authorization =
        await _account!.authorizationClient.authorizeScopes(driveScopes);
    final credentials = AccessCredentials(
      AccessToken('Bearer', authorization.accessToken,
          DateTime.now().add(const Duration(hours: 1))),
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

  /// Landlord: upload the packet, replacing any previous version.
  Future<void> uploadPacket({
    required String meterCode,
    required Map<String, dynamic> packet,
  }) async {
    final api = await _api();
    final folderId = await _meterFolder(api, meterCode);
    final bytes = utf8.encode(jsonEncode(packet));
    final existing = await api.files.list(
      q: "name='landlord.json' and '$folderId' in parents and trashed=false",
      $fields: 'files(id)',
    );
    final media = drive.Media(Stream.value(bytes), bytes.length);
    if (existing.files?.isNotEmpty ?? false) {
      await api.files.update(
        drive.File(),
        existing.files!.first.id!,
        uploadMedia: media,
      );
    } else {
      await api.files.create(
        drive.File(name: 'landlord.json', parents: [folderId]),
        uploadMedia: media,
      );
    }
  }

  /// Tenant: download the landlord's packet. Returns null when not found.
  Future<Map<String, dynamic>?> downloadPacket(String meterCode) async {
    final api = await _api();
    final folderId = await _meterFolder(api, meterCode);
    final found = await api.files.list(
      q: "name='landlord.json' and '$folderId' in parents and trashed=false",
      $fields: 'files(id)',
    );
    if (found.files?.isEmpty ?? true) return null;
    final media = await api.files.get(
      found.files!.first.id!,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;
    final chunks = await media.stream.toList();
    final bytes = chunks.expand((c) => c).toList(growable: false);
    return jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
  }

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
  }) =>
      {
        'version': 1,
        'meterCode': meterCode,
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
              'agentFee': r.agentFee,
              'otherExpenses': r.otherExpenses,
            }
        ],
      };
}
