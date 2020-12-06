import 'dart:io';

const rows = 128;
const columns = 8;

class Seat {
  int row;
  int column;
  String code;
  int id;

  Seat(this.row, this.column) {
    id = row * 8 + column;
    code = "";
  }

  Seat.fromCode(this.code) {
    if (code.length != 10) {
      throw FormatException("code ${code} should have length 10");
    }
    var r = code.substring(0, 7).replaceAll("F", "0").replaceAll("B", "1");
    var c = code.substring(7, 10).replaceAll("L", "0").replaceAll("R", "1");

    column = int.parse(c, radix: 2);
    row = int.parse(r, radix: 2);
    id = row * 8 + column;
  }

  String toString() {
    return "row: ${row}, column: ${column}, code: ${code}, id: ${id}>";
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

List<Seat> toSeats(List<String> codes) {
  return List<Seat>.from(codes.map((code) => Seat.fromCode(code)));
}

Seat maxID(List<Seat> seats) {
  return seats.fold(Seat(-1, -1),
      (previous, current) => previous.id > current.id ? previous : current);
}

Seat missingSeat(List<Seat> seats) {
  var mapping = Map<int, Seat>();
  for (var seat in seats) {
    mapping[seat.id] = seat;
  }
  for (var row = 1; row < rows - 1; row++) {
    for (var column = 0; column < columns - 1; column++) {
      var seat = Seat(row, column);
      if (mapping[seat.id] == null) {
        if (mapping[seat.id - 1] != null && mapping[seat.id + 1] != null) {
          return seat;
        }
      }
    }
  }
}

void main() {
  var codes = load();
  var seats = toSeats(codes);
  print(maxID(seats));

  print(missingSeat(seats));
}
