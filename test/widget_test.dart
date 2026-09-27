// Basic smoke test: the app boots and shows the splash screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fleet_driver_app/main.dart';

void main() {
  testWidgets('App boots and renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FleetDriverApp()));
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
