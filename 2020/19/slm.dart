import 'dart:io';

class Rule {
  String nr;
  List<List<String>> rules;

  Rule(this.nr) : rules = [];

  String toString() {
    return "$nr: $rules";
  }
}

class Input {
  Map<String, Rule> rules;
  Map<String, bool> messages;

  Input(this.rules, this.messages);
}

Input load() {
  var rules = Map<String, Rule>();
  var messages = Map<String, bool>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == "") {
      break;
    }
    var s = line.split(":");
    var nr = s[0];
    var r = Rule(nr);

    var list = s[1].trim();
    s = list.split("|");
    s.forEach((e) => r.rules
        .add(e.trim().split(" ").map((x) => x.replaceAll("\"", "")).toList()));
    rules[nr] = r;
  }

  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    messages[line] = true;
  }
  return Input(rules, messages);
}

List<String> matches(
    Map<String, Rule> rules, String nr, Map<String, List<String>> cache) {
  if (cache[nr] != null) {
    return cache[nr];
  }

  var all = List<String>();

  var rule = rules[nr];

  for (var r in rule.rules) {
    if ("ab".contains(r[0])) {
      return r;
    }
    var r1Matches = matches(rules, r[0], cache);
    if (r.length > 1) {
      var r2Matches = matches(rules, r[1], cache);
      for (var i in r1Matches) {
        for (var j in r2Matches) {
          all.add(i + j);
        }
      }
    } else {
      all.addAll(r1Matches);
    }
  }

  cache[nr] = all;
  return all;
}

List<String> part1(Input i, Map<String, List<String>> cache) {
  var found = <String>[];

  var matches0 = matches(i.rules, "0", cache);
  for (var m in matches0) {
    if (i.messages[m] != null) {
      found.add(m);
    }
  }
  return found;
}

int part2(Input i, List<String> found, Map<String, List<String>> cache) {
  for (var m in found) {
    i.messages.remove(m);
  }

  // Match at least one 42 and equal number of 42 and 31
/*
   0: 8, 11 => (42) (42) (31)
   8: 42 | 42, 8  => (42)
   11: 42, 31| 42, 11, 31 => (42)(31)
*/

  var matches42 = cache["42"];
  var r42 = matches42.join("|");

  var matches31 = cache["31"];
  var r31 = matches31.join("|");

  var reg42 = r"^(" + r42 + r")+";
  var reg31 = r"^(" + r31 + r")+$";
  RegExp exp42 = RegExp(reg42);
  RegExp exp31 = RegExp(reg31);

  var c = 0;
  for (var msg in i.messages.keys) {
    if (exp42.hasMatch(msg)) {
      var tmp = msg;
      tmp = tmp.replaceFirst(exp42, "");
      var l42 = msg.length - tmp.length;

      if (exp31.hasMatch(tmp) && l42 > tmp.length) {
        c++;
      }
    }
  }

  return c + found.length;
}

void main() {
  var input = load();
  var cache = <String, List<String>>{};

  var found = part1(input, cache);
  print(found.length);

  print(part2(input, found, cache));
}
