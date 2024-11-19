import 'recipe_model.dart';

class FilterModel {
  final List<Recipe> allRecipes;
  List<Recipe> filteredRecipes;

  FilterModel(this.allRecipes) : filteredRecipes = List.from(allRecipes);

  void filterByCookTime(int maxCookTime) {
    filteredRecipes = allRecipes.where((recipe) => recipe.cookTime <= maxCookTime).toList();
  }

  void filterByCarbRange(int minCarbs, int maxCarbs) {
    filteredRecipes = allRecipes.where((recipe) {
      final carbs = recipe.macros['carbs'] ?? 0;
      return carbs >= minCarbs && carbs <= maxCarbs;
    }).toList();
  }

  void filterBySugarRange(int minSugar, int maxSugar) {
    filteredRecipes = allRecipes.where((recipe) {
      final sugar = recipe.macros['sugar'] ?? 0;
      return sugar >= minSugar && sugar <= maxSugar;
    }).toList();
  }

  void filterByCuisine(String cuisine) {
    filteredRecipes = allRecipes
        .where((recipe) => recipe.cuisine.toLowerCase() == cuisine.toLowerCase())
        .toList();
  }

  void clearFilters() {
    filteredRecipes = List.from(allRecipes);
  }
}
