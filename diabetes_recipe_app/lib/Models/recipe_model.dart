class Recipe {
  final String title;
  final String cuisine;
  final int cookTime; 
  final List<String> ingredients;
  final List<String> preparationSteps;
  final String imagePath;
  final int carbRange; 
  final int sugarRange;
  bool favOrNah;

  Recipe({
    required this.title,
    required this.cuisine,
    required this.cookTime,
    required this.ingredients,
    required this.preparationSteps,
    required this.imagePath,
    required this.carbRange,
    required this.sugarRange, 
    this.favOrNah = false, 
  });
}
