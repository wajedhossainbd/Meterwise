import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';

/// Renders an [AsyncValue] with consistent loading and error states so screens
/// don't each reinvent the `.when(...)` boilerplate.
///
/// Raw exception text is logged (not shown): Drift/SQL details are meaningless
/// to a landlord and can leak schema internals. The localized message plus an
/// optional Retry action is all the user needs.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    this.onRetry,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        developer.log(
          'AsyncValueView error',
          name: 'MeterWise',
          error: error,
          stackTrace: stackTrace,
        );
        final l = AppLocalizations.of(context);
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    size: 48, color: Theme.of(context).colorScheme.error),
                const SizedBox(height: 12),
                Text(l.commonSomethingWrong,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium),
                if (onRetry != null) ...[
                  const SizedBox(height: 16),
                  FilledButton.tonal(
                    onPressed: onRetry,
                    child: Text(l.actionRetry),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
