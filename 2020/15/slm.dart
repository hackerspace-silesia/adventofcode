import 'dart:io';

List<int> load() {
  var line = stdin.readLineSync();
  return line.split(",").map((x) => int.parse(x)).toList();
}

int run(List<int> sequence, int turns) {
  var indexes = List<int>.filled(turns, -1);
  for (var i = 0; i < sequence.length; i++) {
    indexes[sequence[i]] = i;
  }
  var previous = sequence.last;
  int newPrev;
  for (var i = sequence.length; i < turns; i++) {
    if (indexes[previous] == -1) {
      newPrev = 0;
    } else {
      newPrev = i - indexes[previous] - 1;
    }
    indexes[previous] = i - 1;
    previous = newPrev;
  }
  return previous;
}

void main() {
  var data = load();
  print(run(data, 2020));
  print(run(data, 30000000));
}
