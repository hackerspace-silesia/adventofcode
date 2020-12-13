import 'dart:io';
import 'dart:math';

enum D { NORTH, EAST, SOUTH, WEST }

class Instruction {
  String cmd;
  int val;

  Instruction(this.cmd, this.val);

  String toString() {
    return "$cmd:$val";
  }
}

List<Instruction> load() {
  var ins = List<Instruction>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    var cmd = line[0];
    var val = int.parse(line.substring(1));
    ins.add(Instruction(cmd, val));
  }
  return ins;
}

Point move(Point<int> p, D dir, int val) {
  if (dir == D.NORTH) {
    p = p + Point(0, val);
  }
  if (dir == D.SOUTH) {
    p = p - Point(0, val);
  }
  if (dir == D.EAST) {
    p = p + Point(val, 0);
  }
  if (dir == D.WEST) {
    p = p - Point(val, 0);
  }
  return p;
}

int travel(List<Instruction> instructions) {
  var F = D.EAST;
  var p = Point(0, 0);
  for (var ins in instructions) {
    if (ins.cmd == "N") {
      p = move(p, D.NORTH, ins.val);
    }
    if (ins.cmd == "S") {
      p = move(p, D.SOUTH, ins.val);
    }
    if (ins.cmd == "E") {
      p = move(p, D.EAST, ins.val);
    }
    if (ins.cmd == "W") {
      p = move(p, D.WEST, ins.val);
    }
    if (ins.cmd == "F") {
      p = move(p, F, ins.val);
    }
    if (ins.cmd == "L") {
      var i = F.index - ins.val ~/ 90;
      if (i < 0) {
        F = D.values[D.values.length - i.abs()];
      } else {
        F = D.values[i];
      }
    }
    if (ins.cmd == "R") {
      F = D.values[(F.index + (ins.val ~/ 90)) % 4];
    }
  }
  return p.x.abs() + p.y.abs();
}

int travel2(List<Instruction> instructions) {
  var w = Point(10, 1);
  var s = Point(0, 0);
  for (var ins in instructions) {
    if (ins.cmd == "N") {
      w = move(w, D.NORTH, ins.val);
    }
    if (ins.cmd == "S") {
      w = move(w, D.SOUTH, ins.val);
    }
    if (ins.cmd == "E") {
      w = move(w, D.EAST, ins.val);
    }
    if (ins.cmd == "W") {
      w = move(w, D.WEST, ins.val);
    }
    if (ins.cmd == "F") {
      s = Point(s.x + w.x * ins.val, s.y + w.y * ins.val);
    }
    if (ins.cmd == "L") {
      var i = ins.val ~/ 90;
      switch (i) {
        case 1:
          w = Point(-w.y, w.x);
          break;
        case 2:
          w = Point(-w.x, -w.y);
          break;
        case 3:
          w = Point(w.y, -w.x);
          break;
      }
    }
    if (ins.cmd == "R") {
      var i = ins.val ~/ 90;
      switch (i) {
        case 1:
          w = Point(w.y, -w.x);
          break;
        case 2:
          w = Point(-w.x, -w.y);
          break;
        case 3:
          w = Point(-w.y, w.x);
          break;
      }
    }
    print([w, s]);
  }
  return s.x.abs() + s.y.abs();
}

void main() {
  var ins = load();

  print(travel(ins));
  print(travel2(ins));
}
