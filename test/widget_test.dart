// This is a basic Flutter widget test for the SnapHome starter screen.
//
// It pumps the real app and verifies that the welcoming home screen renders
// the expected title and placeholder content.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:snaphome/main.dart';

void main() {
  testWidgets('SnapHome home screen renders welcome content',
      (WidgetTester tester) async {
    // Build the real app and trigger a frame.
    await tester.pumpWidget(const SnapHomeApp());

    // The AppBar title should read 'SnapHome'.
    expect(find.text('SnapHome'), findsOneWidget);

    // The welcoming placeholder body should render.
    expect(find.text('Welcome to SnapHome'), findsOneWidget);
    expect(
      find.textContaining('AI-powered home decor companion'),
      findsOneWidget,
    );

    // The decorative icon should be present.
    expect(find.byIcon(Icons.chair_outlined), findsOneWidget);
  });
}
