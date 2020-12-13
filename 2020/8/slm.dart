import 'dart:io';

const JUMP = "jmp";
const ACC = "acc";
const NOP = "nop";

class Register {
  int acc;

  Register(this.acc);

  String toString() {
    return "<acc: ${acc}>";
  }
}

abstract class Instruction {
  int value;

  Instruction(this.value);

  int run(Register r);

  String toString() {
    return "${this.runtimeType}(${value})";
  }
}

class JumpInstruction extends Instruction {
  JumpInstruction(int v) : super(v);

  int run(Register r) {
    return value;
  }
}

class AccInstruction extends Instruction {
  AccInstruction(int v) : super(v);

  int run(Register r) {
    r.acc += value;
    return 1;
  }
}

class NopInstruction extends Instruction {
  NopInstruction(int v) : super(v);

  int run(Register r) {
    return 1;
  }
}

Instruction toInstruction(String i, int v) {
  if (i == JUMP) {
    return JumpInstruction(v);
  } else if (i == NOP) {
    return NopInstruction(v);
  } else if (i == ACC) {
    return AccInstruction(v);
  }
  throw FormatException("Unknown instruction ${i}");
}

class Processor {
  int _index;
  Register register;
  List<Instruction> instructions;
  List<int> _visited;

  Processor.withInstructions(this.instructions) {
    register = Register(0);
    _index = 0;
    _visited = List<int>.filled(instructions.length, 0);
  }

  bool run() {
    var next = 0;
    Instruction instruction;

    while (true) {
      instruction = instructions[_index];
      next = instruction.run(register);
      _index += next;
      if (_index >= instructions.length) {
        break;
      }
      if (_visited[_index] > 0) {
        return false;
      }
      _visited[_index] += 1;
    }
    if (_index == instructions.length) {
      return true;
    }
    return false;
  }
}

class Fixer {
  List<Instruction> _instructions;

  Fixer(this._instructions);

  Register fix() {
    for (var i = 0; i < _instructions.length; i++) {
      var instruction = _instructions[i];
      Instruction newInstruction;
      if (instruction is NopInstruction) {
        newInstruction = JumpInstruction(instruction.value);
      } else if (instruction is JumpInstruction) {
        newInstruction = NopInstruction(instruction.value);
      } else {
        continue;
      }

      var newInstructions = List<Instruction>.from(_instructions);
      newInstructions[i] = newInstruction;

      var p = Processor.withInstructions(newInstructions);
      if (p.run()) return p.register;
    }
    return Register(-1);
  }
}

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

List<Instruction> parse(List<String> lines) {
  var instructions = List<Instruction>();

  for (var l in lines) {
    var s = l.split(" ");
    instructions.add(toInstruction(s[0], int.parse(s[1])));
  }
  return instructions;
}

void main() {
  var lines = load();

  var instructions = parse(lines);

  var p = Processor.withInstructions(instructions);
  p.run();
  print(p.register.acc);

  var f = Fixer(instructions);
  print(f.fix().acc);
}
