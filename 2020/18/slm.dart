import 'dart:io';

List<String> load() {
  var lines = List<String>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    lines.add(line);
  }
  return lines;
}

bool isNumber(String n) {
  return int.tryParse(n) != null;
}

List<String> convertRPN(String expr) {
  var out = List<String>();
  var stack = List<String>();
  for (var s in expr.split("")) {
    if (isNumber(s)) {
      out.add(s);
      continue;
    }
    if ("+*".contains(s)) {
      if (stack.isNotEmpty && "*+".contains(stack.last)) {
        out.add(stack.removeLast());
      }
      stack.add(s);
      continue;
    }
    if (s == "(") {
      stack.add(s);
      continue;
    }
    if (s == ")") {
      while (true) {
        var fs = stack.removeLast();
        if (fs == "(") {
          break;
        }
        out.add(fs);
      }
      continue;
    }
  }

  while (stack.isNotEmpty) {
    out.add(stack.removeLast());
  }

  return out;
}

List<String> convertRPN2(String expr) {
  var out = List<String>();
  var stack = List<String>();
  for (var s in expr.split("")) {
    if (isNumber(s)) {
      out.add(s);
      continue;
    }
    if (s == "*") {
      while (stack.isNotEmpty && stack.last == "+") {
        var fs = stack.removeLast();
        out.add(fs);
      }
      stack.add(s);
      continue;
    }
    if (s == "+") {
      stack.add(s);
      continue;
    }
    if (s == "(") {
      stack.add(s);
      continue;
    }
    if (s == ")") {
      while (true) {
        var fs = stack.removeLast();
        if (fs == "(") {
          break;
        }
        out.add(fs);
      }
      continue;
    }
  }

  while (stack.isNotEmpty) {
    out.add(stack.removeLast());
  }

  return out;
}

int calculate(List<String> rpn) {
  var stack = List<dynamic>();
  int a;
  int b;
  int r;

  for (var s in rpn) {
    if (isNumber(s)) {
      stack.add(s);
      continue;
    }
    b = int.parse(stack.removeLast());
    a = int.parse(stack.removeLast());
    if (s == "+") {
      r = a + b;
      stack.add("$r");
    }
    if (s == "*") {
      r = a * b;
      stack.add("$r");
    }
  }
  return int.parse(stack.removeLast());
}

void main() {
  var x = 0;
  var lines = load();

  // part1
  for (var l in lines) {
    x += calculate(convertRPN(l));
  }
  print(x);
  // part2
  x = 0;
  for (var l in lines) {
    x += calculate(convertRPN2(l));
  }
  print(x);
}
