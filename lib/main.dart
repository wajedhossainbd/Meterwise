import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/widgets/splash_gate.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'features/settings/data/settings_repository.dart';
import 'features/tariff/data/tariff_repository.dart';
import 'features/tariff/data/tariff_version_repository.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Seed the default DPDC tariff and the settings row before the first frame so
  // the app is usable immediately. Reuse the same container for the running app
  // so the database connection opened here is shared.
  final container = ProviderContainer();
  await container.read(tariffRepositoryProvider).ensureSeeded();
  await container.read(settingsRepositoryProvider).ensureSeeded();
  // Snapshot the current tariff as "Version 1" so historical months resolve to
  // a versioned tariff (no-op once versions exist).
  await container.read(tariffVersionRepositoryProvider).ensureSeeded();
  // Restore the appearance choice before the first frame.
  final settings = await container.read(settingsRepositoryProvider).get();
  container
      .read(themeModeControllerProvider.notifier)
      .setThemeMode(themeModeFromStorage(settings.themeMode));

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MeterWiseApp(),
    ),
  );
}

/// Root widget. Wires the GoRouter, the Material 3 themes and the reactive
/// theme-mode selector together. All app state flows through Riverpod from here
/// down — there is no business logic in this widget.
class MeterWiseApp extends ConsumerWidget {
  const MeterWiseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final settings = ref.watch(appSettingsProvider);
    final locale = ref.watch(localeProvider);

    // Before the user has completed the first-run wizard, show it instead of the
    // main (router-driven) app. `onboarded` flips to true once they choose a
    // billing mode, swapping in the full app.
    final onboarded = settings.value?.onboarded ?? true;

    const localizationsDelegates = AppLocalizations.localizationsDelegates;
    const supportedLocales = AppLocalizations.supportedLocales;
    final lightTheme = AppTheme.light();
    final darkTheme = AppTheme.dark();

    if (!onboarded) {
      return MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        builder: (context, child) =>
            SplashGate(child: child ?? const SizedBox.shrink()),
        home: const OnboardingScreen(),
      );
    }

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      builder: (context, child) =>
          SplashGate(child: child ?? const SizedBox.shrink()),
      routerConfig: appRouter,
    );
  }
}
