import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';
import '../../viewmodels/filter/filter_viewmodel.dart';
import '../../viewmodels/home/homescreenRecipes_viewmodel.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';

class HomeScreenRecipesView extends StatelessWidget {
  final FilterPresenter presenter;
  final ProfilePresenter profilePresenter;
  final VoidCallback pressed;

  HomeScreenRecipesView({
    required this.presenter,
    required this.profilePresenter,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenRecipesViewModel>(
      builder: (context, viewModel, child) {
        final recipes = presenter.filteredRecipesNotifier.value;
        return Scaffold(
          appBar: AppBar(
            title: Text("Recipes"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_alt),
                onPressed: pressed,
              ),
            ],
          ),
          body: recipes.isEmpty
              ? Center(child: Text("No recipes match the selected filters"))
              : ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return recipeCardDetails(context, recipe, viewModel);
                  },
                ),
        );
      },
    );
  }

  Widget recipeCardDetails(
      BuildContext context, Recipe recipe, HomeScreenRecipesViewModel viewModel) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.asset(
          recipe.imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          recipe.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Cuisine: ${recipe.cuisine}\n"
          "Cook Time: ${recipe.cookTime} mins\n"
          "Carbs: ${recipe.carbRange} grams\n"
          "Sugar: ${recipe.sugarRange} grams",
        ),
        trailing: IconButton(
          icon: Icon(
            recipe.favOrNah ? Icons.favorite : Icons.favorite_border,
            color: recipe.favOrNah ? Colors.red : null,
          ),
          onPressed: () {
            viewModel.changeFavStatus(recipe);
          },
        ),
        onTap: () {
          viewModel.recipeDetails(context, recipe);
        },
      ),
    );
  }
}
