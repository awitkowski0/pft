import 'package:flutter_test/flutter_test.dart';
import 'package:pft/core/sanitize_response.dart';

void main() {
  group('sanitizeAiResponse', () {
    test('removes stray double quotes', () {
      expect(sanitizeAiResponse('some "" text'), 'some text');
    });

    test('removes stray single quotes', () {
      expect(sanitizeAiResponse("some '' text"), 'some text');
    });

    test('removes markdown bold markers', () {
      expect(sanitizeAiResponse('some **bold** text'), 'some bold text');
    });

    test('removes multiple bold markers', () {
      expect(
        sanitizeAiResponse('**one** and **two**'),
        'one and two',
      );
    });

    test('removes italic single asterisks', () {
      expect(sanitizeAiResponse('some *italic* text'), 'some italic text');
    });

    test('removes bold-italic triple asterisks', () {
      expect(sanitizeAiResponse('***bold italic***'), 'bold italic');
    });

    test('removes orphaned single asterisk', () {
      expect(sanitizeAiResponse('text* more'), 'text more');
    });

    test('removes mixed asterisk patterns', () {
      expect(
        sanitizeAiResponse('*mix* **of** ***all*** patterns'),
        'mix of all patterns',
      );
    });

    test('removes empty parentheses', () {
      expect(sanitizeAiResponse('text () here'), 'text here');
    });

    test('removes empty brackets', () {
      expect(sanitizeAiResponse('text [] here'), 'text here');
    });

    test('removes empty braces', () {
      expect(sanitizeAiResponse('text {} here'), 'text here');
    });

    test('removes word count patterns', () {
      expect(
        sanitizeAiResponse('some text 120 words'),
        'some text',
      );
    });

    test('removes Word count pattern', () {
      expect(
        sanitizeAiResponse('Word count: 85'),
        '',
      );
    });

    test('removes word count with varied spacing', () {
      expect(
        sanitizeAiResponse('Briefing text. 85words'),
        'Briefing text.',
      );
    });

    test('collapses triple newlines to double', () {
      expect(
        sanitizeAiResponse('line1\n\n\n\nline2'),
        'line1\n\nline2',
      );
    });

    test('collapses double spaces to single', () {
      expect(sanitizeAiResponse('too  many  spaces'), 'too many spaces');
    });

    test('trims whitespace', () {
      expect(sanitizeAiResponse('  hello world  '), 'hello world');
    });

    test('preserves normal text unchanged', () {
      final input = 'Good morning. Today is a great day for a workout.';
      expect(sanitizeAiResponse(input), input);
    });

    test('handles empty input', () {
      expect(sanitizeAiResponse(''), '');
    });

    test('combined sanitization', () {
      final input = '**Focus on form.**  ""  120 words  \n\n\n\n*Next* paragraph.';
      final result = sanitizeAiResponse(input);
      expect(result, contains('Focus on form.'));
      expect(result, contains('Next'));
      expect(result, contains('paragraph.'));
      expect(result, isNot(contains('**')));
      expect(result, isNot(contains('*')));
      expect(result, isNot(contains('""')));
      expect(result, isNot(contains('120 words')));
    });
  });
}
