import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';

class RecipeDetailsViewModel extends ChangeNotifier {
  final Recipe _recipe;

  RecipeDetailsViewModel({required Recipe recipe}) : _recipe = recipe;

  String get title => _recipe.title;
  String get cuisine => _recipe.cuisine;
  int get cookTime => _recipe.cookTime;
  List<String> get ingredients => _recipe.ingredients;
  List<String> get preparationSteps => _recipe.preparationSteps;
  int get carbRange => _recipe.carbRange;
  int get sugarRange => _recipe.sugarRange;
}

