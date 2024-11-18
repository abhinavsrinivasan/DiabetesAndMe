class Recipe {
  String title;
  List<String> ingredients;
  String preparationSteps;
  Map<String, int> macros; // Example: {'carbs': 50, 'sugar': 10, 'calories': 200}
  String cuisine;
  int cookTime;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.preparationSteps,
    required this.macros,
    required this.cuisine,
    required this.cookTime,
  });
}