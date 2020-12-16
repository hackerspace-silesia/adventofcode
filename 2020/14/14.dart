import 'dart:io';
import 'dart:math';

int set(int val, int n) {
  return val | 1 << n;
}

int clear(int val, int n) {
  return val & ~(1 << n);
}

abstract class Input {
  Map<int, int> get memory;
}

class Instruction {
  int address;
  int value;

  Instruction(this.address, this.value);

  String toString() {
    return "[$address]=$value";
  }
}

class Memory extends Input {
  String mask;
  int _andMask;
  int _orMask;
  List<Instruction> _instructions;
  Map<int, int> _memory;

  Memory(this.mask, this._andMask, this._orMask, this._instructions) {}

  @override
  Map<int, int> get memory {
    if (_memory != null) return _memory;
    _memory = Map<int, int>();
    for (var i in _instructions) {
      _memory[i.address] = _maskValue(i.value);
    }
    return _memory;
  }

  int _maskValue(int val) {
    val |= _orMask;
    val &= _andMask;
    return val;
  }

  String toString() {
    var or = _orMask.toRadixString(2);
    var and = _andMask.toRadixString(2);
    return "mask: $mask, or mask: $or, and mask: $and, ins: $_instructions, m: $memory";
  }
}

class Decoder extends Input {
  String mask;
  int _orMask;
  List<Instruction> _instructions;
  Map<int, int> _memory;

  Decoder(this.mask, this._orMask, this._instructions) {}

  @override
  Map<int, int> get memory {
    if (_memory != null) return _memory;

    _memory = Map<int, int>();
    for (var i in _instructions) {
      var address = i.address | _orMask;
      var adds = Set<int>();
      adds.add(address);

      for (var i = 0; i < mask.length; i++) {
        var index = mask.length - i - 1;
        if (mask[index] != "X") {
          continue;
        }
        var newAdds = List<int>();
        for (var a in adds) {
          newAdds.add(set(a, i));
          newAdds.add(clear(a, i));
        }
        adds.addAll(newAdds);
      }

      for (var add in adds) {
        _memory[add] = i.value;
      }
    }
    return _memory;
  }

  String toString() {
    var or = _orMask.toRadixString(2);
    return "mask: $mask, or mask: $or, ins: $_instructions, m: $memory";
  }
}

List load() {
  var ops = List<Memory>();
  var decoders = List<Decoder>();
  var memR = RegExp(r"^mem\[(\d+)\] = (\d+)$");
  var line = stdin.readLineSync();
  while (true) {
    var sMask = line.replaceFirst("mask = ", "");
    var mask = Map<int, int>();
    for (var i = 0; i < line.length; i++) {
      var index = line.length - i - 1;
      if (line[index] == "1") {
        mask[i] = 1;
      } else if (line[index] == "0") {
        mask[i] = 0;
      }
    }

    var _andHelper = int.parse("1" * 36, radix: 2);
    var orMask = 0, andMask = _andHelper;
    for (var m in mask.entries) {
      if (m.value == 1) {
        orMask += pow(2, m.key);
      } else if (m.value == 0) {
        andMask -= pow(2, m.key);
      }
    }

    var ins = List<Instruction>();
    while (true) {
      line = stdin.readLineSync();
      if (line == null || !memR.hasMatch(line)) {
        ops.add(Memory(sMask, andMask, orMask, ins));
        decoders.add(Decoder(sMask, orMask, ins));
        break;
      }
      var m = memR.firstMatch(line);
      ins.add(Instruction(int.parse(m.group(1)), int.parse(m.group(2))));
    }

    if (line == null) {
      break;
    }
  }
  return [ops, decoders];
}

int sum(List<Input> blocks) {
  var s = 0;
  var m = Map<int, int>();
  for (var b in blocks) {
    for (var e in b.memory.entries) {
      m[e.key] = e.value;
    }
  }
  for (var b in m.values) {
    s += b;
  }
  return s;
}

void main() {
  var data = load();

  print(sum(data[0]));
  print(sum(data[1]));
}
