import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../presenters/filter_presenter.dart';
import '../presenters/profile_presenter.dart';
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

    final recipes = widget.presenter.getFilteredRecipes();

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
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return recipeCardDetails(context, recipe);
        },
      ),
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
        title: Text(recipe.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Cuisine: ${recipe.cuisine}\nCook Time: ${recipe.cookTime} mins"),
        //heart
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

  //favoriting logic
  void changeFavStatus(Recipe recipe) {
    setState(() {
      recipe.favOrNah = !recipe.favOrNah; //make it the opposite
      if (recipe.favOrNah) {
        widget.profilePresenter.userModel.favoriteRecipes.add(recipe);
      } else {
        widget.profilePresenter.userModel.favoriteRecipes.remove(recipe);
      }
    });
  }

  //go into recipe
  void recipeDetails(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsView(recipe: recipe),
      ),
    );
  }
}
