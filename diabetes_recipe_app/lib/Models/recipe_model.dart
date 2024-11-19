class Recipe {
  final String title;
  final String cuisine;
  final int cookTime;
  final Map<String, int> macros;
  final List<String> ingredients;
  final List<String> preparationSteps; // Correctly define as List<String>

  Recipe({
    required this.title,
    required this.cuisine,
    required this.cookTime,
    required this.macros,
    required this.ingredients,
    required this.preparationSteps, // Match the parameter type
  });
}
