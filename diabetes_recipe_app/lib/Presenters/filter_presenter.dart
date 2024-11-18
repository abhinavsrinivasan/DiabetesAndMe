import '../Models/filter_model.dart';
import '../Models/recipe_model.dart';

class FilterPresenter {
  final FilterModel model;

  FilterPresenter(List<Recipe> recipes) : model = FilterModel(recipes);

  // Expose filtered recipes to the view
  List<Recipe> getFilteredRecipes() => model.filteredRecipes;

  // Delegate filter actions to the Model
  void applyCookTimeFilter(int maxCookTime) {
    model.filterByCookTime(maxCookTime);
  }

  void applyCarbRangeFilter(int minCarbs, int maxCarbs) {
    model.filterByCarbRange(minCarbs, maxCarbs);
  }

  void applySugarRangeFilter(int minSugar, int maxSugar) {
    model.filterBySugarRange(minSugar, maxSugar);
  }

  void applyCuisineFilter(String cuisine) {
    model.filterByCuisine(cuisine);
  }

  void resetFilters() {
    model.clearFilters();
  }
}