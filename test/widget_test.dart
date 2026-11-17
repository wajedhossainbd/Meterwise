// Widget tests for reusable presentation components.
//
// These cover the shared UI building blocks without touching the database.
// Database wiring is covered by db_override_test.dart and the billing logic by
// billing_engine_test.dart. (Full-app widget tests are avoided here because
// Drift's real async I/O does not progress under the fake-async test binding.)

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/core/widgets/feature_placeholder.dart';
import 'package:meterwise/core/widgets/section_card.dart';
import 'package:meterwise/features/dashboard/presentation/widgets/stat_card.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('FeaturePlaceholder shows title and message', (tester) async {
    await tester.pumpWidget(_wrap(const FeaturePlaceholder(
      icon: Icons.info,
      title: 'No data',
      message: 'Add something',
    )));

    expect(find.text('No data'), findsOneWidget);
    expect(find.text('Add something'), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);
  });

  testWidgets('StatCard shows value and label', (tester) async {
    await tester.pumpWidget(_wrap(const StatCard(
      label: 'Estimated bill',
      value: '৳1,250.00',
      icon: Icons.request_quote,
      color: Colors.teal,
    )));

    expect(find.text('৳1,250.00'), findsOneWidget);
    expect(find.text('Estimated bill'), findsOneWidget);
  });

  testWidgets('LabelValueRow renders label and value', (tester) async {
    await tester.pumpWidget(_wrap(const LabelValueRow('Total', '৳500')));

    expect(find.text('Total'), findsOneWidget);
    expect(find.text('৳500'), findsOneWidget);
  });
}
