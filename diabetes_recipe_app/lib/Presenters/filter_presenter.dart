//

import '../models/filter_model.dart';
import '../models/recipe_model.dart';

class FilterPresenter {
  final FilterModel model;

  FilterPresenter(List<Recipe> recipes) : model = FilterModel(recipes);

  List<Recipe> getFilteredRecipes() => model.filteredRecipes;

 
}
