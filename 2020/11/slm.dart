import "dart:io";

typedef canSit = bool Function(Map<int, Map<int, String>>, int, int);
typedef shouldFree = bool Function(Map<int, Map<int, String>>, int, int);

const SIZE = 97;

Map<int, Map<int, String>> load() {
  var lines = Map<int, Map<int, String>>();
  for (var i = 0; i < SIZE; i++) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }

    lines[i] = line.split("").asMap();
  }
  return lines;
}

bool canSit1(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i in [-1, 0, 1]) {
    for (var j in [-1, 0, 1]) {
      if (i == 0 && j == 0) continue;
      if (seats[x + i] != null && seats[x + i][y + j] == "#") return false;
    }
  }
  return true;
}

bool isDownFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = x - 1; i >= 0; i--) {
    if (seats[i][y] == "L") return true;
    if (seats[i][y] == "#") return false;
  }
  return true;
}

bool isUpFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = x + 1; i < SIZE; i++) {
    if (seats[i][y] == "L") return true;
    if (seats[i][y] == "#") return false;
  }
  return true;
}

bool isLeftFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = y - 1; i >= 0; i--) {
    if (seats[x][i] == "L") return true;
    if (seats[x][i] == "#") return false;
  }
  return true;
}

bool isRightFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = y + 1; i < SIZE; i++) {
    if (seats[x][i] == "L") return true;
    if (seats[x][i] == "#") return false;
  }
  return true;
}

bool isLDFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = x - 1, j = y - 1; i >= 0 && j >= 0; i--, j--) {
    if (seats[i][j] == "L") return true;
    if (seats[i][j] == "#") return false;
  }
  return true;
}

bool isRDFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = x - 1, j = y + 1; i >= 0 && j < SIZE; i--, j++) {
    if (seats[i][j] == "L") return true;
    if (seats[i][j] == "#") return false;
  }
  return true;
}

bool isLUFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = x + 1, j = y - 1; i < SIZE && j >= 0; i++, j--) {
    if (seats[i][j] == "L") return true;
    if (seats[i][j] == "#") return false;
  }
  return true;
}

bool isRUFree(Map<int, Map<int, String>> seats, int x, int y) {
  for (var i = x + 1, j = y + 1; i < SIZE && j < SIZE; i++, j++) {
    if (seats[i][j] == "L") return true;
    if (seats[i][j] == "#") return false;
  }
  return true;
}

bool shouldLeave1(Map<int, Map<int, String>> seats, int x, int y) {
  int counter = 0;
  for (var i in [-1, 0, 1]) {
    for (var j in [-1, 0, 1]) {
      if (i == 0 && j == 0) continue;
      if (seats[x + i] != null && seats[x + i][y + j] == "#") counter++;
    }
  }
  return counter >= 4;
}

bool canSit2(Map<int, Map<int, String>> seats, int x, int y) {
  if (!isLeftFree(seats, x, y)) return false;
  if (!isRightFree(seats, x, y)) return false;
  if (!isUpFree(seats, x, y)) return false;
  if (!isDownFree(seats, x, y)) return false;
  if (!isLUFree(seats, x, y)) return false;
  if (!isLDFree(seats, x, y)) return false;
  if (!isRUFree(seats, x, y)) return false;
  if (!isRDFree(seats, x, y)) return false;
  return true;
}

bool shouldLeave2(Map<int, Map<int, String>> seats, int x, int y) {
  int counter = 0;
  if (!isLeftFree(seats, x, y)) counter++;
  if (!isRightFree(seats, x, y)) counter++;
  if (!isUpFree(seats, x, y)) counter++;
  if (!isDownFree(seats, x, y)) counter++;
  if (!isLUFree(seats, x, y)) counter++;
  if (!isLDFree(seats, x, y)) counter++;
  if (!isRUFree(seats, x, y)) counter++;
  if (!isRDFree(seats, x, y)) counter++;
  return counter >= 5;
}

List update(
    Map<int, Map<int, String>> seats, canSit sit, shouldFree shouldLeave) {
  var newSeats = Map<int, Map<int, String>>();
  for (var i = 0; i < SIZE; i++) {
    newSeats[i] = Map<int, String>();
  }

  var changed = false;
  for (var i = 0; i < SIZE; i++) {
    for (var j = 0; j < SIZE; j++) {
      newSeats[i][j] = seats[i][j];
      if (seats[i][j] == "#" && shouldLeave(seats, i, j)) {
        newSeats[i][j] = "L";
        changed = true;
      } else if (seats[i][j] == "L" && sit(seats, i, j)) {
        newSeats[i][j] = "#";
        changed = true;
      }
    }
  }
  return [changed, newSeats];
}

int occupied(Map<int, Map<int, String>> seats) {
  var o = 0;
  for (var i = 0; i < SIZE; i++) {
    for (var j = 0; j < SIZE; j++) {
      if (seats[i][j] == "#") o++;
    }
  }
  return o;
}

int fill(Map<int, Map<int, String>> seats, canSit sit, shouldFree leave) {
  while (true) {
    var l = update(seats, sit, leave);
    var updated = l[0];
    if (!updated) break;
    seats = l[1];
  }
  ;
  return occupied(seats);
}

void main() {
  var data = load();

  print(fill(data, canSit1, shouldLeave1));
  print(fill(data, canSit2, shouldLeave2));
}
