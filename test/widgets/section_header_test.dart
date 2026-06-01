import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pft/ui/widgets/section_header.dart';

void main() {
  testWidgets('renders title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Test Title'),
        ),
      ),
    );

    expect(find.text('TEST TITLE'), findsOneWidget);
  });

  testWidgets('renders trailing text when provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Title', trailing: '5 ITEMS'),
        ),
      ),
    );

    expect(find.text('TITLE'), findsOneWidget);
    expect(find.text('5 ITEMS'), findsOneWidget);
  });

  testWidgets('does not render trailing when null', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'Title'),
        ),
      ),
    );

    expect(find.text('TITLE'), findsOneWidget);
    expect(find.textContaining('ITEMS'), findsNothing);
  });

  testWidgets('title is uppercased', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SectionHeader(title: 'hello World'),
        ),
      ),
    );

    expect(find.text('HELLO WORLD'), findsOneWidget);
  });
}
