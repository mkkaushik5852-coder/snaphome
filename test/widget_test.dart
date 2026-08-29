// Basic Flutter widget test for the Lumo app.
//
// It pumps the real app and verifies that the animated splash screen renders
// the Lumo wordmark and tagline. We use pump() (not pumpAndSettle) because the
// splash contains looping/entrance animations that never fully settle.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:snaphome/main.dart';

void main() {
  testWidgets('Lumo splash renders the wordmark and tagline',
      (WidgetTester tester) async {
    await tester.pumpWidget(const LumoApp());

    // Let the first frames render (entrance animations begin).
    await tester.pump(const Duration(milliseconds: 100));

    // The Lumo wordmark should be present on the splash screen.
    expect(find.text('Lumo'), findsOneWidget);

    // The tagline (all-caps overline) should render.
    expect(find.text('DESIGN THAT FEELS LIKE HOME'), findsOneWidget);
  });
}
