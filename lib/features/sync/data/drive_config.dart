/// OAuth client ID is injected at build time via `--dart-define` from the
/// git-ignored `.secrets/google_client_id.txt`. OAuth client IDs are public
/// identifiers, but keeping them out of source avoids needless exposure.
const String driveClientId = String.fromEnvironment('METERWISE_DRIVE_CLIENT_ID');

/// Web-application OAuth client ID, required as `serverClientId` on Android
/// by google_sign_in v7. Injected from `.secrets/google_server_client_id.txt`.
const String driveServerClientId =
    String.fromEnvironment('METERWISE_DRIVE_SERVER_CLIENT_ID');

const List<String> driveScopes = <String>[
  'https://www.googleapis.com/auth/drive',
];
