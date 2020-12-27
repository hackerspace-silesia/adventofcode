import "dart:io";

int getLoopSize(int key) {
  int start = 1;
  int ls = 0;
  while (start != key) {
    ls++;
    start *= 7;
    start %= 20201227;
  }
  return ls;
}

int getKey(int sb, int loopSize) {
  var start = 1;
  for (var i = 0; i < loopSize; i++) {
    start *= sb;
    start %= 20201227;
  }
  return start;
}

void main() {
  var c = int.parse(stdin.readLineSync());
  var d = int.parse(stdin.readLineSync());
  print(getKey(d, getLoopSize(c)));
  print(getKey(c, getLoopSize(d)));
}
