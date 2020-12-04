import 'dart:io';

class PasswordMeta {
  String password;
  String letter;
  int atLeast;
  int atMost;

  PasswordMeta(this.password, this.letter, this.atLeast, this.atMost);

  String toString() {
    return "${atLeast}-${atMost} ${letter}: ${password}";
  }
}

Map<String, int> passwordStats(String password) {
  var stats = Map<String, int>();
  for (var char in password.split("")) {
    stats[char] = stats.putIfAbsent(char, () => 0) + 1;
  }
  return stats;
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

List<PasswordMeta> parseLines(List<String> lines) {
  var meta = List<PasswordMeta>();
  for (var l in lines) {
    var s = l.split(" ");
    if (s.length != 3) {
      throw FormatException('Excpected 3 elements in a line');
    }
    var password = s[2];
    var letter = s[1][0];
    var policy = s[0].split("-");
    var atLeast = int.parse(policy[0]);
    var atMost = int.parse(policy[1]);
    meta.add(PasswordMeta(password, letter, atLeast, atMost));
  }
  return meta;
}

bool isValid1(PasswordMeta p) {
  var stats = passwordStats(p.password);
  stats.putIfAbsent(p.letter, () => 0);
  if (p.atLeast <= stats[p.letter] && stats[p.letter] <= p.atMost) {
    return true;
  }
  return false;
}

bool isValid2(PasswordMeta p) {
  var index1 = p.atLeast - 1;
  var index2 = p.atMost - 1;
  var l1 = p.password[index1];
  var l2 = p.password[index2];
  if (l1 == l2) {
    return false;
  }
  if (l1 != p.letter && l2 != p.letter) {
    return false;
  }
  return true;
}

List<PasswordMeta> validPasswords(
    List<PasswordMeta> passwords, bool isValid(PasswordMeta p)) {
  var valid = List<PasswordMeta>();
  for (var password in passwords) {
    if (isValid(password)) {
      valid.add(password);
    }
  }
  return valid;
}

void main() {
  var lines = load();
  var parsed = parseLines(lines);
  print(validPasswords(parsed, isValid1).length);
  print(validPasswords(parsed, isValid2).length);
}
