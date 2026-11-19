import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/soft_ui.dart';
import '../../../core/widgets/animated_count.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/data/settings_repository.dart';

/// First-run tour: a swipeable guided intro (what the app does → how it
/// works → choose billing mode). The final choice stores the mode and marks
/// onboarding complete.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  bool _saving = false;

  static const _pageCount = 3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) => _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );

  Future<void> _choose({required bool multiTenant}) async {
    setState(() => _saving = true);
    await ref
        .read(settingsRepositoryProvider)
        .update(multiTenant: multiTenant, onboarded: true);
    // The root widget watches `onboarded` and swaps to the main app.
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final onLastPage = _page == _pageCount - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip straight to the choice page.
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: onLastPage
                    ? const SizedBox(height: 48)
                    : TextButton(
                        onPressed: () => _goTo(_pageCount - 1),
                        child: Text(l.tourSkip),
                      ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (p) => setState(() => _page = p),
                children: [
                  _IntroPage(l: l),
                  _HowItWorksPage(l: l),
                  _ChooseModePage(
                    l: l,
                    saving: _saving,
                    onChoose: _choose,
                  ),
                ],
              ),
            ),
            // Dots + Next.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: Row(
                children: [
                  Row(
                    children: [
                      for (var i = 0; i < _pageCount; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 6),
                          width: i == _page ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == _page
                                ? theme.colorScheme.primary
                                : theme.colorScheme.primary
                                    .withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  if (!onLastPage)
                    FilledButton.icon(
                      onPressed: () => _goTo(_page + 1),
                      icon: Text(l.tourNext),
                      label: const Icon(Icons.arrow_forward, size: 18),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeSlideIn(
            child: SoftSurface(
              depth: SoftDepth.strong,
              borderRadius: Soft.circle,
              padding: const EdgeInsets.all(AppTokens.s8),
              child: Icon(Icons.bolt,
                  size: 64, color: Soft.accent(context)),
            ),
          ),
          const SizedBox(height: 28),
          FadeSlideIn(
            index: 1,
            child: Text(
              l.welcomeTitle(AppConstants.appName),
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          FadeSlideIn(
            index: 2,
            child: Text(
              l.tourIntroBody,
              style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksPage extends StatelessWidget {
  const _HowItWorksPage({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = Soft.accent(context);
    final steps = [
      (Icons.speed, l.tourStep1Title, l.tourStep1Body),
      (Icons.bolt, l.tourStep2Title, l.tourStep2Body),
      (Icons.receipt_long, l.tourStep3Title, l.tourStep3Body),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(
            child: Text(
              l.tourHowTitle,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 24),
          for (final (i, s) in steps.indexed) ...[
            FadeSlideIn(
              index: i + 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SoftInset(
                    radius: AppTokens.radiusControl,
                    padding: const EdgeInsets.all(AppTokens.s3),
                    child: Icon(s.$1, color: accent, size: 26),
                  ),
                  const SizedBox(width: AppTokens.s4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.$2,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: AppTokens.s1),
                        Text(s.$3,
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (i != steps.length - 1) const SizedBox(height: 22),
          ],
        ],
      ),
    );
  }
}

class _ChooseModePage extends StatelessWidget {
  const _ChooseModePage({
    required this.l,
    required this.saving,
    required this.onChoose,
  });

  final AppLocalizations l;
  final bool saving;
  final Future<void> Function({required bool multiTenant}) onChoose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 12),
          FadeSlideIn(
            child: Text(
              l.onboardingQuestion,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FadeSlideIn(
            index: 1,
            child: _ChoiceCard(
              icon: Icons.home_outlined,
              title: l.onboardingSingle,
              description: l.onboardingSingleDesc,
              onTap: saving ? null : () => onChoose(multiTenant: false),
            ),
          ),
          const SizedBox(height: 16),
          FadeSlideIn(
            index: 2,
            child: _ChoiceCard(
              icon: Icons.apartment_outlined,
              title: l.onboardingMulti,
              description: l.onboardingMultiDesc,
              onTap: saving ? null : () => onChoose(multiTenant: true),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l.onboardingChangeLater,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SoftSurface(
      depth: SoftDepth.subtle,
      onTap: onTap,
      padding: const EdgeInsets.all(AppTokens.s5),
      child: Row(
        children: [
          SoftSurface(
            depth: SoftDepth.subtle,
            borderRadius: BorderRadius.circular(AppTokens.radiusControl),
            padding: const EdgeInsets.all(AppTokens.s3),
            child: Icon(icon, size: 28, color: Soft.accent(context)),
          ),
          const SizedBox(width: AppTokens.s4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppTokens.s1),
                Text(description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Soft.muted(context)),
        ],
      ),
    );
  }
}
