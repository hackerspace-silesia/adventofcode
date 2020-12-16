import 'dart:io';

class Rule {
  int min;
  int max;

  Rule(this.min, this.max);

  String toString() {
    return "<$min - $max>";
  }

  bool isValid(int n) {
    return (min <= n && n <= max);
  }
}

class TicketRules {
  Map<String, List<Rule>> rules;

  TicketRules(this.rules);

  String toString() {
    return "$rules";
  }

  bool isValid(int number) {
    for (var n in rules.values) {
      for (var r in n) {
        if (r.isValid(number)) {
          return true;
        }
      }
    }
    return false;
  }

  List<String> setRulesOrder(List<List<int>> tickets) {
    var columns = List<List<int>>.generate(rules.length, (i) => List<int>());

    for (var i = 0; i < rules.length; i++) {
      for (var ticket in tickets) {
        columns[i].add(ticket[i]);
      }
    }

    var validRules =
        List<List<String>>.generate(columns.length, (i) => List<String>());

    for (var c = 0; c < columns.length; c++) {
      for (var entry in rules.entries) {
        var validRule = true;
        for (var i in columns[c]) {
          var rule = entry.value;
          if (!rule[0].isValid(i) && !rule[1].isValid(i)) {
            validRule = false;
            break;
          }
        }
        if (validRule) {
          validRules[c].add(entry.key);
        }
      }
    }

    var assigned = List<String>.filled(rules.length, "");
    assign(validRules, assigned, 0);
    return assigned;
  }

  bool assign(List<List<String>> validRules, List<String> assigned, int index) {
    if (index == validRules.length) {
      return true;
    }

    for (var rule in validRules[index]) {
      if (assigned.indexOf(rule) != -1) continue;

      assigned[index] = rule;
      if (assign(validRules, assigned, index + 1)) {
        return true;
      }
    }
    assigned[index] = "";
    return false;
  }
}

List load() {
  var ruleR = RegExp(r"(\d+-\d+)");
  var rules = Map<String, List<Rule>>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == "") {
      break;
    }
    var s = line.split(":");
    var name = s[0].trim();
    var r = ruleR
        .allMatches(s[1])
        .map((rule) => rule.group(1).split("-"))
        .map((rule) => Rule(int.parse(rule[0]), int.parse(rule[1])))
        .toList();
    rules[name] = r;
  }

  stdin.readLineSync();
  var line = stdin.readLineSync();
  var ticket = line.split(",").map((x) => int.parse(x)).toList();

  stdin.readLineSync();
  stdin.readLineSync();
  var tickets = List<List<int>>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    tickets.add(line.split(",").map((x) => int.parse(x)).toList());
  }

  return [TicketRules(rules), ticket, tickets];
}

int invalidTickets(TicketRules t, List<List<int>> tickets) {
  int sum = 0;
  for (var ticket in tickets) {
    for (var n in ticket) {
      if (!t.isValid(n)) {
        sum += n;
      }
    }
  }
  return sum;
}

List<List<int>> validTickets(TicketRules t, List<List<int>> tickets) {
  var valid = List<List<int>>();
  for (var ticket in tickets) {
    var isValid = true;
    for (var n in ticket) {
      if (!t.isValid(n)) {
        isValid = false;
        break;
      }
    }
    if (isValid) {
      valid.add(ticket);
    }
  }
  return valid;
}

int part2(List<String> order, List<int> ticket) {
  var ret = 1;
  for (var i = 0; i < order.length; i++) {
    if (order[i].startsWith("departure")) {
      ret *= ticket[i];
    }
  }
  return ret;
}

void main() {
  var data = load();
  var rules = data[0];
  var myTicket = data[1];
  var tickets = data[2];

  var s = invalidTickets(rules, tickets);
  print(s);

  var valid = validTickets(rules, tickets);
  var order = rules.setRulesOrder(valid);
  print(part2(order, myTicket));
}
