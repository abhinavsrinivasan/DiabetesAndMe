import 'recipe_model.dart';

class FilterModel {
  final List<Recipe> allRecipes;
  List<Recipe> filteredRecipes;

  FilterModel(this.allRecipes) : filteredRecipes = List.from(allRecipes);
}
