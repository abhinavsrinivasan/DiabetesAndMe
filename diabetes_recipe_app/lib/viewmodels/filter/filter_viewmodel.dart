import 'package:flutter/material.dart';
import '../../models/filter_model.dart';
import '../../models/recipe_model.dart';

class FilterViewModel extends ChangeNotifier {
  final FilterModel _model;

  final Set<String> _selectedFilters = {};

  FilterViewModel(List<Recipe> recipes) : _model = FilterModel(recipes);

  List<Recipe> get filteredRecipes => _model.filteredRecipes;

  bool isFilterSelected(String category, String option) {
    return _selectedFilters.contains("$category:$option");
  }

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
    String? selectedCuisine;
    int? maxCookTime;
    int? maxCarbRange;
    int? maxSugarRange;

    for (var filter in _selectedFilters) {
      if (filter.startsWith("cuisine:")) {
        selectedCuisine = filter.split(":")[1];
      } else if (filter.startsWith("cookTime:")) {
        if (filter.contains("Low")) maxCookTime = 30;
        if (filter.contains("Medium")) maxCookTime = 60;
      } else if (filter.startsWith("carbs:")) {
        if (filter.contains("Low")) maxCarbRange = 10;
        if (filter.contains("Medium")) maxCarbRange = 20;
      } else if (filter.startsWith("sugar:")) {
        if (filter.contains("Low")) maxSugarRange = 5;
        if (filter.contains("Medium")) maxSugarRange = 10;
      }
    }

    final filtered = _model.allRecipes.where((recipe) {
      final matchesCuisine = selectedCuisine == null || recipe.cuisine == selectedCuisine;
      final matchesCookTime = maxCookTime == null || recipe.cookTime <= maxCookTime;
      final matchesCarbRange = maxCarbRange == null || recipe.carbRange <= maxCarbRange;
      final matchesSugarRange = maxSugarRange == null || recipe.sugarRange <= maxSugarRange;
      return matchesCuisine && matchesCookTime && matchesCarbRange && matchesSugarRange;
    }).toList();

    _model.filteredRecipes = filtered;
    notifyListeners();
  }

  void resetFilters() {
    _selectedFilters.clear();
    _model.filteredRecipes = List.from(_model.allRecipes);
    notifyListeners();
  }
}
