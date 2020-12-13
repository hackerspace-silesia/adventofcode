import "dart:io";

import 'package:graphs/graphs.dart';

const target = "shiny gold";

class Graph {
  final Map<Node, List<Node>> nodes;

  Graph(this.nodes);

  String toString() {
    return "Graph: ${nodes}";
  }
}

class Node {
  final String name;
  final int amount;

  Node(this.name, this.amount);

  String toString() {
    return "Edge(name: ${name}, amount: ${amount})";
  }

  bool operator ==(dynamic other) {
    if (other is! Node) return false;
    Node n = other;
    return name == n.name;
  }

  @override
  int get hashCode {
    return name.hashCode;
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

List<List<Node>> findAllContaining(Graph g, target) {
  var paths = List<List<Node>>();
  var targetNode = Node(target, -1);
  for (var node in g.nodes.keys) {
    if (node == targetNode) {
      continue;
    }
    var p = shortestPath<Node>(node, targetNode, (node) => g.nodes[node]);
    if (p != null) {
      paths.add(p);
    }
  }
  return paths;
}

int findContained(Graph g, Node start) {
  var nodes = g.nodes[start];
  var s = 0;
  for (var n in nodes) {
    s += n.amount + n.amount * findContained(g, n);
  }
  return s;
}

Graph parse(List<String> lines) {
  var nodes = Map<Node, List<Node>>();

  var nodeReg = RegExp(r"^(\w+ \w+) bags contain");
  var edgesReg = RegExp(r"(\d+ \w+ \w+)");
  for (var l in lines) {
    var node = nodeReg.firstMatch(l).group(1);
    var edges = edgesReg
        .allMatches(l)
        .map((edge) => edge.group(1).split(" "))
        .map((edge) => Node(edge.sublist(1, 3).join(" "), int.parse(edge[0])))
        .toList();
    nodes[Node(node, 0)] = edges != null ? edges : List<Node>();
  }
  return Graph(nodes);
}

void main() {
  var lines = load();
  var g = parse(lines);

  print(findAllContaining(g, target).length);

  var targetNode = Node(target, 1);
  print(findContained(g, targetNode));
}
