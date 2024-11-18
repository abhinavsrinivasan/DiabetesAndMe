import 'recipe_model.dart';

class FilterModel {
  final List<Recipe> allRecipes;
  List<Recipe> filteredRecipes;

  // Constructor
  FilterModel(this.allRecipes) : filteredRecipes = List.from(allRecipes);

  // Filter by cook time
  void filterByCookTime(int maxCookTime) {
    filteredRecipes = allRecipes.where((recipe) => recipe.cookTime <= maxCookTime).toList();
  }

  // Filter by carbohydrate range
  void filterByCarbRange(int minCarbs, int maxCarbs) {
    filteredRecipes = allRecipes.where((recipe) {
      final carbs = recipe.macros['carbs'] ?? 0;
      return carbs >= minCarbs && carbs <= maxCarbs;
    }).toList();
  }

  // Filter by sugar range
  void filterBySugarRange(int minSugar, int maxSugar) {
    filteredRecipes = allRecipes.where((recipe) {
      final sugar = recipe.macros['sugar'] ?? 0;
      return sugar >= minSugar && sugar <= maxSugar;
    }).toList();
  }

  // Filter by cuisine
  void filterByCuisine(String cuisine) {
    filteredRecipes = allRecipes
        .where((recipe) => recipe.cuisine.toLowerCase() == cuisine.toLowerCase())
        .toList();
  }

  // Clear all filters
  void clearFilters() {
    filteredRecipes = List.from(allRecipes);
  }
}