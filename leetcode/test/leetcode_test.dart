import 'dart:math';

import 'package:leetcode/longest_common_prefix.dart';
import 'package:leetcode/roman_to_integer.dart';
import 'package:leetcode/two_sum.dart';
import 'package:leetcode/validParentheses.dart';
import 'package:test/test.dart';

final _random = Random();

void main() {
  test('validParentheses test', () {
    final strings = '[][';
    meastureTime(() => validParentheses(strings));
  });

  test('longestCommonPrefix test', () {
    final strings = ["flower", "flow", "flight"];
    // final strings = ["dog", "racecar", "car"];
    meastureTime(() => longestCommonPrefix(strings));
  });

  test('romanToInt test', () {
    final romanNumber = 'MCMXCIV';
    // final romanNumber = 'III';
    // final romanNumber = 'LVIII';
    meastureTime(() => romanToInt_n(romanNumber));
  });
  test('twoSum_n2 testing', () {
    final nums = List.generate(100 + 1, (index) => index);
    final target = 100;
    meastureTime(() => twoSum_n2(nums, target));
  });

  test('twoSum_n testing', () {
    final nums = List.generate(100, (index) => index);
    final target = 100;
    meastureTime(() => twoSum_n(nums, target));
  });
}

meastureTime(dynamic Function() fn) {
  final stopWatch = Stopwatch()..start();
  final result = fn();
  stopWatch.stop();
  print('result : $result - elapsedMicroseconds : ${stopWatch.elapsedMicroseconds}');
}
