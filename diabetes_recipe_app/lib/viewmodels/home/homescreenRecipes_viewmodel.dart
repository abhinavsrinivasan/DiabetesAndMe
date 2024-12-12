import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../../models/user_model.dart';
import '../filter/filter_viewmodel.dart';
import '../../views/home/recipe_details_view.dart';



class HomeScreenRecipesViewModel extends ChangeNotifier {
  final List<Recipe> recipeList;
  final UserModel userModel;

  HomeScreenRecipesViewModel({
    required this.recipeList,
    required this.userModel,
  });

  void changeFavStatus(Recipe recipe) {
    recipe.favOrNah = !recipe.favOrNah;
    if (recipe.favOrNah) {
      userModel.favoriteRecipes.add(recipe);
    } else {
      userModel.favoriteRecipes.remove(recipe);
    }
    notifyListeners();
  }

  void recipeDetails(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsView(recipe: recipe),
      ),
    );
  }
}
