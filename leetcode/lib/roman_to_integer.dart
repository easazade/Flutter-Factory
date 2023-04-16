const simplifiedRoman = <String, String>{
  'IV': 'Q',
  'IX': 'W',
  'XL': 'E',
  'XC': 'R',
  'CD': 'G',
  'CM': 'T',
};

const romanNumericMap = <String, int>{
  'I': 1,
  'V': 5,
  'X': 10,
  'L': 50,
  'C': 100,
  'D': 500,
  'M': 1000,
  // abbriviation letters mapping
  'Q': 4,
  'W': 9,
  'E': 40,
  'R': 90,
  'G': 400,
  'T': 900,
};

int romanToInt_n(String romanNumber) {
  romanNumber = romanNumber.toUpperCase();
  // O(1)
  simplifiedRoman.forEach((roman, abbr) {
    romanNumber = romanNumber.replaceAll(roman, abbr); // O(1)
  });

  return romanNumber
      .split('') // O(1)
      .fold(0, (previousValue, letter) => romanNumericMap[letter]! + previousValue); // n * O(1)
}
