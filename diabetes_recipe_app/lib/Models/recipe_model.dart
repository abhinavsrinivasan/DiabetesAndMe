//

class Recipe {
  final String title;
  final String cuisine;
  final int cookTime;
  final Map<String, int> macros;
  final List<String> ingredients;
  final List<String> preparationSteps;
  final String imagePath;
  bool favOrNah;

  Recipe({
    required this.title,
    required this.cuisine,
    required this.cookTime,
    required this.macros,
    required this.ingredients,
    required this.preparationSteps,
    required this.imagePath,
    this.favOrNah = false, //for the favorite functionality(setting default to false)
  });
}
