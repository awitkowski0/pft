String sanitizeAiResponse(String text) {
  // Strip all markdown asterisk patterns (AI output is unpredictable)
  text = text.replaceAll('***', '');  // bold+italic
  text = text.replaceAll('**', '');   // bold
  text = text.replaceAll('*', '');    // italic

  // Strip empty quotes
  text = text.replaceAll('""', '');
  text = text.replaceAll("''", '');

  // Strip empty brackets/parens
  text = text.replaceAll('()', '');
  text = text.replaceAll('[]', '');
  text = text.replaceAll('{}', '');

  // Strip word-count lines: "120 words", "Word count: 120", etc.
  text = text.replaceAll(
    RegExp(r'\b\d{1,4}\s*words?\b', caseSensitive: false),
    '',
  );
  text = text.replaceAll(
    RegExp(r'\bword count:?\s*\d{1,4}\b', caseSensitive: false),
    '',
  );

  // Collapse triple+ newlines to double
  text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  // Collapse double+ spaces to single
  text = text.replaceAll(RegExp(r'  +'), ' ');

  return text.trim();
}
