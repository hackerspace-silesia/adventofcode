import 'dart:io';

class Passport {
  String ecl;
  String pid;
  String hcl;
  String cid;
  String hgt;
  String eyr;
  String byr;
  String iyr;

  Passport.fromMap(Map<String, String> data) {
    ecl = data['ecl'];
    pid = data['pid'];
    eyr = data['eyr'];
    hcl = data['hcl'];
    byr = data['byr'];
    iyr = data['iyr'];
    cid = data['cid'];
    hgt = data['hgt'];
  }

  String toString() {
    return "ecl: ${ecl}, pid: ${pid}, eyr: ${eyr}, hcl: ${hcl}, byr: ${byr}, iyr: ${iyr}, cid: ${cid}, hgt: ${hgt}";
  }

  bool isValidNorthPole() {
    if (this.byr == null) return false;
    var byr = int.tryParse(this.byr);
    if (byr == null || byr < 1920 || byr > 2002) return false;

    if (this.iyr == null) return false;
    var iyr = int.tryParse(this.iyr);
    if (iyr == null || iyr < 2010 || iyr > 2020) return false;

    if (this.eyr == null) return false;
    var eyr = int.tryParse(this.eyr);
    if (eyr == null || eyr < 2020 || eyr > 2030) return false;

    if (hcl == null ||
        hcl.length != 7 ||
        hcl[0] != "#" ||
        int.tryParse(hcl.substring(1), radix: 16) == null) return false;

    if (!["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ecl))
      return false;

    var pidRe = RegExp(r"^\d{9}$");
    if (pid == null || !pidRe.hasMatch(pid)) return false;

    if (hgt == null || !(hgt.endsWith("in") || hgt.endsWith("cm")))
      return false;
    var h = int.tryParse(hgt.substring(0, hgt.length - 2));
    if (h == null) return false;
    if (hgt.endsWith("in") && (h < 59 || h > 76)) return false;
    if (hgt.endsWith("cm") && (h < 150 || h > 193)) return false;

    return true;
  }

  bool isValid() {
    return (isValidNorthPole() && cid != null);
  }

  bool isValidNorthPoleSimple() {
    return (ecl != null &&
        pid != null &&
        eyr != null &&
        hcl != null &&
        byr != null &&
        iyr != null &&
        hgt != null);
  }
}

List<Passport> parse(List<String> lines) {
  var passports = List<Passport>();
  var entry = "";
  lines.add(""); // to handle EOF where there is no ""
  for (var line in lines) {
    if (line == "") {
      var map = Map<String, String>();
      for (var pair in entry.split(" ")) {
        if (pair == "") {
          continue;
        }

        var kv = pair.split(":");
        if (kv.length != 2) {
          throw FormatException("Invalid data in ${pair}");
        }
        map[kv[0]] = kv[1];
      }
      var passport = Passport.fromMap(map);
      passports.add(passport);
      entry = "";
    } else {
      entry += " " + line;
    }
  }
  return passports;
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

int validPasswordsSimple(List<Passport> passports) {
  var valid = 0;
  for (var passport in passports) {
    if (passport.isValidNorthPoleSimple()) {
      valid++;
    }
  }
  return valid;
}

int validPasswords(List<Passport> passports) {
  var valid = 0;
  for (var passport in passports) {
    if (passport.isValidNorthPole()) {
      valid++;
    }
  }
  return valid;
}

void main() {
  var lines = load();

  var passports = parse(lines);
  print(validPasswordsSimple(passports));
  print(validPasswords(passports));
}
