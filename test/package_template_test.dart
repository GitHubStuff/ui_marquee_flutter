import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_marquee_flutter/ui_marquee_flutter.dart';

void main() {
  testWidgets('SignBoard displays the correct text',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: UIMarqueeWidget(
          message: 'Test message',
        ),
      ),
    ));

    // Create the Finders.
    final finder = find.text('Test message');

    // Use the `findsOneWidget` matcher to verify that the Text widget appears exactly once in the widget tree.
    expect(finder, findsOneWidget);
  });
}
