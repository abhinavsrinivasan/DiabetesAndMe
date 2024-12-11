import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../../viewmodels/filter/filter_viewmodel.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';
import 'recipe_details_view.dart';

class HomeScreenRecipesView extends StatefulWidget {
  final FilterPresenter presenter;
  final ProfilePresenter profilePresenter;
  final VoidCallback pressed;

  HomeScreenRecipesView({
    required this.presenter,
    required this.profilePresenter,
    required this.pressed,
  });

  @override
  HomeScreenRecipesViewState createState() => HomeScreenRecipesViewState();
}

class HomeScreenRecipesViewState extends State<HomeScreenRecipesView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Recipe>>(
      valueListenable: widget.presenter.filteredRecipesNotifier,
      builder: (context, recipes, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Recipes"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_alt),
                onPressed: widget.pressed,
              ),
            ],
          ),
          body: recipes.isEmpty
              ? Center(child: Text("No recipes match the selected filters"))
              : ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return recipeCardDetails(context, recipe);
                  },
                ),
        );
      },
    );
  }

  Widget recipeCardDetails(BuildContext context, Recipe recipe) {
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
          changeFavStatus(recipe);
        },
      ),
      onTap: () {
        recipeDetails(context, recipe);
      },
    ),
  );
}


  void changeFavStatus(Recipe recipe) {
    setState(() {
      recipe.favOrNah = !recipe.favOrNah;
      if (recipe.favOrNah) {
        widget.profilePresenter.userModel.favoriteRecipes.add(recipe);
      } else {
        widget.profilePresenter.userModel.favoriteRecipes.remove(recipe);
      }
    });
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
