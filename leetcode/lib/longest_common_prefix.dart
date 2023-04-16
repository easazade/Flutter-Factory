String longestCommonPrefix(List<String> strings) {
  final prefixes = <String, int>{};

  for (var string in strings) {
    for (var i = 0; i < string.length; i++) {
      final prefix = string.substring(0, i + 1);
      if (prefixes.containsKey(prefix)) {
        prefixes[prefix] = prefixes[prefix]! + 1;
      } else {
        prefixes[prefix] = 1;
      }
    }
  }

  return prefixes.entries.fold(MapEntry('', 2), (previousValue, element) {
    if (element.value > previousValue.value) {
      return element;
    } else if (element.value == previousValue.value && element.key.length > previousValue.key.length) {
      return element;
    } else {
      return previousValue;
    }
  }).key;
}

String longestCommonPrefix2(List<String> strs) {
  String commonPrefix = strs.first;
  for (final word in strs) {
    while (!word.startsWith(commonPrefix)) {
      commonPrefix = commonPrefix.substring(0, commonPrefix.length - 1);
    }
  }
  return commonPrefix;
}
