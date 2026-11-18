import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ReleaseInfo {
  const ReleaseInfo({
    required this.version,
    required this.apkUrl,
    required this.htmlUrl,
    required this.notes,
  });

  final String version;
  final String apkUrl;
  final String htmlUrl;
  final String notes;
}

/// Checks GitHub Releases for a newer sideload APK and downloads it in-app.
/// Disabled in Play Store builds via `METERWISE_GITHUB_UPDATER=false`.
class UpdateService {
  const UpdateService._();

  static const String _latestRelease =
      'https://api.github.com/repos/wajedhossainbd/Meterwise/releases/latest';

  static Future<ReleaseInfo?> checkLatest() async {
    try {
      final response = await http
          .get(
            Uri.parse(_latestRelease),
            headers: const {
              'Accept': 'application/vnd.github+json',
              'User-Agent': 'MeterWise-App',
            },
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return null;
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final tag = (body['tag_name'] as String?) ?? '';
      if (tag.isEmpty) return null;

      final assets = (body['assets'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>();
      final apk = assets
          .where((a) => (a['name'] as String?)?.endsWith('.apk') ?? false)
          .cast<Map<String, dynamic>?>()
          .firstOrNull;
      if (apk == null) return null;

      return ReleaseInfo(
        version: tag.replaceFirst(RegExp(r'^v'), ''),
        apkUrl: apk['browser_download_url'] as String,
        htmlUrl: (body['html_url'] as String?) ?? '',
        notes: (body['body'] as String?) ?? '',
      );
    } on Object {
      return null; // Offline or API hiccup — never block the app.
    }
  }

  static Future<String> downloadApk(
    String url,
    void Function(int received, int total)? onProgress,
  ) async {
    final client = http.Client();
    final request = await client.send(http.Request('GET', Uri.parse(url)));
    final total = request.contentLength ?? 0;
    final chunks = <List<int>>[];
    var received = 0;
    await for (final chunk in request.stream) {
      chunks.add(chunk);
      received += chunk.length;
      onProgress?.call(received, total);
    }
    client.close();
    final bytes = chunks.expand((c) => c).toList(growable: false);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/meterwise-update.apk');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// True when [latest] is newer than [current] (`major.minor.patch`).
  static bool isNewer(String latest, String current) {
    List<int> parts(String v) => v
        .replaceFirst(RegExp(r'^v'), '')
        .split(RegExp(r'[.+-]'))
        .take(3)
        .map((p) => int.tryParse(p) ?? 0)
        .toList();
    final a = parts(latest);
    final b = parts(current);
    for (var i = 0; i < 3; i++) {
      if (a[i] > b[i]) return true;
      if (a[i] < b[i]) return false;
    }
    return false;
  }
}
