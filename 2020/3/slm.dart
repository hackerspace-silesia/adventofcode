import 'dart:io';

enum Object { Empty, Tree }

class Point {
  int x;
  int y;

  Point(this.x, this.y);

  bool operator ==(dynamic other) {
    if (other is! Point) return false;
    Point o = other;
    return (x == o.x && y == o.y);
  }

  @override
  int get hashCode {
    return x.hashCode + y.hashCode;
  }

  String toString() {
    return "<${x},${y}>";
  }
}

class Graph {
  Map<Point, Object> _map;
  Point _position;
  Point _relativePosition;
  int _maxRows;
  int _maxColumns;

  Graph(this._map, this._position, this._maxRows, this._maxColumns);

  Graph.fromList(List<String> lines) {
    _position = Point(0, 0);
    _relativePosition = Point(0, 0);
    _map = Map<Point, Object>();
    _maxRows = lines.length;
    _maxColumns = lines[0].length;

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      for (var j = 0; j < line.length; j++) {
        if (line[j] == "#") {
          _map[Point(j, i)] = Object.Tree;
        }
      }
    }
  }

  String toString() {
    var s = "";
    _map.forEach((k, v) => s += " ${k}:${v} ");
    return s;
  }

  bool Move(Point delta) {
    if (_relativePosition.y + delta.y >= _maxRows) {
      return false;
    }
    _relativePosition.y += delta.y;

    _relativePosition.x += delta.x;
    if (_relativePosition.x >= _maxColumns) {
      _relativePosition.x -= _maxColumns;
    }
    _position.x += delta.x;
    _position.y += delta.y;
    return true;
  }

  bool SetPosition(Point delta) {
    _position.x = _relativePosition.x = delta.x;
    _position.y = _relativePosition.y = delta.y;
  }

  Object CurrentObject() {
    return _map[_relativePosition] ?? Object.Empty;
  }

  Point Position() {
    return _position;
  }
}

int traverse(Graph g, Point delta) {
  g.SetPosition(Point(0, 0));
  var trees = 0;
  while (g.Move(delta)) {
    var o = g.CurrentObject();

    if (o == Object.Tree) {
      trees += 1;
    }
  }
  return trees;
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

void main() {
  var lines = load();
  var map = Graph.fromList(lines);

  print(traverse(map, Point(3, 1)));
  print(traverse(map, Point(1, 1)) *
      traverse(map, Point(3, 1)) *
      traverse(map, Point(5, 1)) *
      traverse(map, Point(7, 1)) *
      traverse(map, Point(1, 2)));
}
