List<int> twoSum_n2(List<int> nums, int target) {
  for (var i = 0; i < nums.length; i++) {
    final part1 = nums[i];
    final part2 = target - part1;
    final part2Index = nums.indexOf(part2);

    if (part2Index != -1) {
      return [i, part2Index];
    }
  }

  throw Exception('nums list must contain at least two numbers that sum of the matches the target');
}

List<int> twoSum_n(List<int> nums, int target) {
  final map = <int, int>{};

  for (int x = 0; x <= nums.length; x++) {
    int remains = target - nums[x]; //Calculate what number we need
    if (map.containsKey(remains)) {
      return [x, map[remains]!];
    }
    map[nums[x]] = x;
  }

  return [];
}
