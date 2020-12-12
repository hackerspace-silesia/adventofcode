import 'dart:io';

List<int> load() {
  var lines = List<int>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    lines.add(int.parse(line));
  }
  return lines;
}

bool isValid(List<int> ints) {
  for (var i = 1; i < ints.length; i++) {
    if (ints[i] - ints[i - 1] > 3) return false;
  }
  return true;
}

List<int> difference(List<int> ints) {
  ints.sort();
  ints.insert(0, 0);
  ints.add(ints[ints.length - 1] + 3);

  var diff = List<int>();
  for (var i = 1; i < ints.length; i++) {
    diff.add(ints[i] - ints[i - 1]);
  }

  return diff;
}

int combinations(List<int> ints) {
  var c = 0;
  for (var i = 0; i < ints.length - 1; i++) {
    if (ints[i] + ints[i + 1] <= 3) {
      var newList = ints.sublist(i + 1, ints.length);
      newList[0] += ints[i];
      c += combinations(newList) + 1;
    }
  }
  return c;
}

int possibilities(List<int> ints) {
  var p = 1;
  var currIndex = 0;
  while (true) {
    var indexOf3 = ints.indexOf(3, currIndex);
    if (indexOf3 == -1) break;
    var subList = ints.sublist(currIndex, indexOf3 + 1);
    var c = combinations(subList) + 1;
    p *= c;
    currIndex = indexOf3 + 1;
  }
  return p;
}

void main() {
  var data = load();

  var diff = difference(data);
  var ones = diff.where((x) => x == 1).toList().length;
  var threes = diff.where((x) => x == 3).toList().length;
  print(ones * threes);

  var p = possibilities(diff);
  print(p);
}
