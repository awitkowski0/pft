import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pft/ui/widgets/briefing_card.dart';

void main() {
  testWidgets('renders title uppercased', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BriefingCard(title: 'morning test', body: 'Body text'),
        ),
      ),
    );

    expect(find.text('MORNING TEST'), findsOneWidget);
  });

  testWidgets('renders body text as-is', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BriefingCard(title: 'Title', body: 'Plain text body'),
        ),
      ),
    );

    expect(find.text('Plain text body'), findsOneWidget);
  });

  testWidgets('does not render markdown bold as rich text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BriefingCard(title: 'Title', body: 'Some **bold** text'),
        ),
      ),
    );

    // Should render as plain text including asterisks if present
    // (sanitization strips them before reaching the card, but the card
    //  itself should render input as-is without interpretation)
    expect(find.text('Some **bold** text'), findsOneWidget);
  });

  testWidgets('renders multiline body', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BriefingCard(
            title: 'Title',
            body: 'Line one\n\nLine two',
          ),
        ),
      ),
    );

    expect(find.text('Line one\n\nLine two'), findsOneWidget);
  });
}
