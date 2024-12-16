//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';
import '../../viewmodels/filter/filter_viewmodel.dart';
import '../../viewmodels/home/homescreenRecipes_viewmodel.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';

class HomeScreenRecipesView extends StatelessWidget {
  final FilterViewModel filterViewModel;
  final ProfileViewModel profileViewModel; 
  final VoidCallback pressed;

  HomeScreenRecipesView({
    required this.filterViewModel,
    required this.profileViewModel,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    final recipes = filterViewModel.filteredRecipes;

    return Consumer<HomeScreenRecipesViewModel>(
      builder: (context, viewModel, child) {
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
          body: ListView.builder(
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

  //for recipe details
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
