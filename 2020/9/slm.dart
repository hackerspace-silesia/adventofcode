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

bool hasSum(Set<int> ints, int target) {
  for (var i in ints) {
    if (ints.contains(target - i)) return true;
  }
  return false;
}

int noSum(List<int> ints) {
  var start = 25;
  var preamble = 25;
  for (var i = start; i < ints.length; i++) {
    if (!hasSum(ints.sublist(i - preamble, i).toSet(), ints[i])) {
      return ints[i];
    }
  }
  return -1;
}

int listSum(List<int> ints) {
  return ints.fold(0, (x, y) => x + y);
}

List<int> sum(List<int> data, target) {
  var ret = List<int>();
  for (var i in data) {
    if (i == target) {
      ret = List<int>();
      continue;
    }
    ret.add(i);
    if (listSum(ret) < target) {
      continue;
    }
    while (listSum(ret) > target) {
      ret.removeAt(0);
    }
    if (listSum(ret) == target) break;
  }

  ret.sort();
  return ret;
}

void main() {
  var data = load();
  var t = noSum(data);
  print(t);

  data = sum(data, t);
  print(data[0] + data[data.length - 1]);
}
