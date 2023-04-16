const openBrackets = ['{', '[', '('];
const closeBrackets = ['}', ']', ')'];

bool validParentheses(String brackets) {
  var readOpenBrackets = '';

  while (brackets.isNotEmpty) {
    final bracket = brackets[0];
    if (bracket.isCloseBracket) {
      if (readOpenBrackets.isEmpty) {
        return false;
      }
      final expectedCloseBrackets = closeBracketsFor(readOpenBrackets);
      if (!brackets.startsWith(expectedCloseBrackets)) {
        return false;
      } else {
        brackets = brackets.substring(readOpenBrackets.length);
        readOpenBrackets = '';
      }
    } else {
      readOpenBrackets += bracket;
      brackets = brackets.substring(1);
    }
  }

  if (readOpenBrackets.isNotEmpty) {
    return false;
  }

  return true;
}

extension StringX on String {
  bool get isOpenBracket => openBrackets.contains(this);
  bool get isCloseBracket => closeBrackets.contains(this);
}

String closeBracketsFor(String brackets) {
  final closings = brackets
      .split('')
      .map((bracket) {
        final index = openBrackets.indexOf(bracket);
        final closeBracket = closeBrackets[index];
        return closeBracket;
      })
      .toList()
      .reversed
      .join();

  print('process closed brackets for open brackets | open $brackets | close $closings');
  return closings;
}
