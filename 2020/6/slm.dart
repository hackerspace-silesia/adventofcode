import "dart:io";

class Group {
  List<String> answers;

  Group() {
    answers = List<String>();
  }

  String uniqueAnswers() {
    var merged = answers.fold("", (a, b) => a + b);
    return merged.split("").toSet().join();
  }

  String everyoneYesAnswers() {
    return answers
        .fold(answers.first.split("").toSet(),
            (a, b) => a.intersection(b.split("").toSet()))
        .join();
  }

  String toString() {
    return "$answers";
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

List<Group> parse(List<String> answers) {
  var groups = List<Group>();
  var g = Group();
  for (var answer in answers) {
    if (answer != "") {
      g.answers.add(answer);
    } else {
      groups.add(g);
      g = Group();
    }
  }
  groups.add(g);
  return groups;
}

int allUniqueCount(List<Group> groups) {
  var sum = 0;
  for (var g in groups) {
    sum += g.uniqueAnswers().length;
  }
  return sum;
}

int allYesCount(List<Group> groups) {
  var sum = 0;
  for (var g in groups) {
    sum += g.everyoneYesAnswers().length;
  }
  return sum;
}

void main() {
  var lines = load();

  var groups = parse(lines);
  print(allUniqueCount(groups));
  print(allYesCount(groups));
}
