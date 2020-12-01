import 'dart:io';
import 'package:trotter/trotter.dart';
import 'dart:convert';

int combinationSum(List x) {
  return x.fold(0, (previous, current) => previous + current);
}

int multipleCombination(List x) {
  return x.fold(1, (previous, current) => previous * current);
}

List findSum(List<int> ints, int combinations, int sum) {
  final combos = Combinations(combinations, ints);
  for (var i = 0; i < combos.length.toInt(); i++) {
    if (combinationSum(combos[i]) == sum) {
      return combos[i];
    }
  }
}

void main() {
  List<int> ints = [];
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    var value = int.parse(line);
    ints.add(value);
  }
  var numbers = findSum(ints, 2, 2020);
  print(multipleCombination(numbers));

  numbers = findSum(ints, 3, 2020);
  print(multipleCombination(numbers));
}
