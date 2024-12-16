import 'package:flutter/material.dart';
import '../../models/filter_model.dart';
import '../../models/recipe_model.dart';

class FilterViewModel extends ChangeNotifier {
  final FilterModel _model;
  final Set<String> _selectedFilters = {};

  FilterViewModel({required List<Recipe> recipes}) : _model = FilterModel(recipes);

  List<Recipe> get filteredRecipes => _model.filteredRecipes;

  bool isFilterSelected(String category, String option) =>
      _selectedFilters.contains("$category:$option");

  void toggleFilter(String category, String option) {
    final filterKey = "$category:$option";
    if (_selectedFilters.contains(filterKey)) {
      _selectedFilters.remove(filterKey);
    } else {
      _selectedFilters.add(filterKey);
    }
    notifyListeners();
  }

  void applyFilters() {
    List<String> selectedCuisines = [];
    List<int> maxCookTimes = [];
    List<int> maxCarbRanges = [];
    List<int> maxSugarRanges = [];
    bool highCookTime = false;

    for (var filter in _selectedFilters) {
      if (filter.contains("cuisine:")) {
        selectedCuisines.add(filter.split(":")[1]);
      } else if (filter.contains("cookTime:Low")) {
        maxCookTimes.add(30);
      } else if (filter.contains("cookTime:Medium")) {
        maxCookTimes.add(60);
      } else if (filter.contains("cookTime:High")) {
        highCookTime = true; 
      } else if (filter.contains("carbs:Low")) {
        maxCarbRanges.add(10);
      } else if (filter.contains("carbs:Medium")) {
        maxCarbRanges.add(20);
      } else if (filter.contains("sugar:Low")) {
        maxSugarRanges.add(5);
      } else if (filter.contains("sugar:Medium")) {
        maxSugarRanges.add(10);
      }
    }

    _model.filteredRecipes = _model.allRecipes.where((recipe) {
      final matchesCuisine =
          selectedCuisines.isEmpty || selectedCuisines.contains(recipe.cuisine);

      final matchesCookTime = highCookTime
          ? recipe.cookTime > 60 
          : maxCookTimes.isEmpty || maxCookTimes.any((max) => recipe.cookTime <= max);

      final matchesCarbRange =
          maxCarbRanges.isEmpty || maxCarbRanges.any((max) => recipe.carbRange <= max);

      final matchesSugarRange =
          maxSugarRanges.isEmpty || maxSugarRanges.any((max) => recipe.sugarRange <= max);

      return matchesCuisine && matchesCookTime && matchesCarbRange && matchesSugarRange;
    }).toList();

    notifyListeners();
  }

  void resetFilters() {
    _selectedFilters.clear();
    _model.filteredRecipes = List.from(_model.allRecipes);
    notifyListeners();
  }
}
