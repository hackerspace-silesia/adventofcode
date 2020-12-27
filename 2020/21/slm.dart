import 'dart:io';
import 'dart:collection';

class Food {
  List<String> ingredients;
  List<String> alergens;

  Food(this.ingredients, this.alergens);

  String toString() {
    return "i: $ingredients, a: $alergens";
  }
}

List<Food> load() {
  var data = List<Food>();
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) {
      break;
    }
    var splitted = line.split("(");
    var s = splitted[0].trim();
    var ingredients = s.split(" ").map((x) => x.trim()).toList();

    var a = splitted[1].replaceAll(")", "");
    a = a.replaceAll("contains", "");
    a = a.trim();
    var alergens = a.split(",").map((x) => x.trim()).toList();
    var f = Food(ingredients, alergens);
    data.add(f);
  }
  return data;
}

void p(List<Food> food) {
  var allIngredients = <String>{};
  for (var f in food) {
    allIngredients.addAll(f.ingredients);
  }

  var maybe = Map<String, Set<String>>();

  // add all ingredients listed in a line with alergen to alergen list
  for (var f in food) {
    for (var a in f.alergens) {
      maybe.putIfAbsent(a, () => <String>{});
      for (var i in f.ingredients) {
        maybe[a].add(i);
      }
    }
  }

  // remove ingredients which are not listed everywhere where alergen is listed
  for (var f in food) {
    for (var a in f.alergens) {
      // potential ingredients ;)
      var pi = Set<String>.from(maybe[a]);
      for (var i in pi) {
        if (!f.ingredients.contains(i)) {
          maybe[a].remove(i);
        }
      }
    }
  }

  // at this point there is at least one mapping where there is only one igredient for one alergen
  // now it removes this ingredient from others alergens list.
  var hasAlergen = SplayTreeMap<String, String>();
  while (true) {
    String ing;
    for (var e in maybe.entries) {
      if (e.value.length == 1) {
        ing = e.value.first;
        hasAlergen[e.key] = ing;
        break;
      }
    }
    if (ing == null) {
      break;
    }

    for (var i in maybe.values) {
      i.remove(ing);
    }
  }

  var count = 0;
  for (var f in food) {
    for (var i in f.ingredients) {
      if (!hasAlergen.values.contains(i)) count++;
    }
  }
  print(count);
  print(hasAlergen.values.join(","));
}

void main() {
  var data = load();
  p(data);
}
