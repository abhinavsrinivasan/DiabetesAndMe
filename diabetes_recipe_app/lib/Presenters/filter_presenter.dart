import '../models/filter_model.dart';
import '../models/recipe_model.dart';
import 'package:flutter/material.dart';

class FilterPresenter {
  final FilterModel model;
  final ValueNotifier<List<Recipe>> filteredRecipesNotifier;

  FilterPresenter(List<Recipe> recipes)
      : model = FilterModel(recipes),
        filteredRecipesNotifier = ValueNotifier<List<Recipe>>(recipes);

  List<Recipe> getFilteredRecipes() => filteredRecipesNotifier.value;

  void applyFilters({
    String? cuisine,
    int? maxCookTime,
    int? maxCarbRange,
    int? maxSugarRange,
  }) {
    final filtered = model.allRecipes.where((recipe) {
      final matchesCuisine = cuisine == null || recipe.cuisine == cuisine;
      final matchesCookTime = maxCookTime == null || recipe.cookTime <= maxCookTime;
      final matchesCarbRange = maxCarbRange == null || recipe.carbRange <= maxCarbRange;
      final matchesSugarRange = maxSugarRange == null || recipe.sugarRange <= maxSugarRange;
      return matchesCuisine && matchesCookTime && matchesCarbRange && matchesSugarRange;
    }).toList();

    model.filteredRecipes = filtered;
    filteredRecipesNotifier.value = filtered; //for valueNotifier
  }

  void resetFilters() {
    model.filteredRecipes = List.from(model.allRecipes);
    filteredRecipesNotifier.value = model.filteredRecipes; //again
  }
}
