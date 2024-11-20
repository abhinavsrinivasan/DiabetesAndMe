import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../presenters/filter_presenter.dart';
import '../presenters/profile_presenter.dart';
import 'recipe_details_view.dart';

class HomeScreenRecipesView extends StatefulWidget {
  final FilterPresenter presenter;
  final ProfilePresenter profilePresenter; 
  final VoidCallback onFilterPressed;

  HomeScreenRecipesView({
    required this.presenter,
    required this.profilePresenter,
    required this.onFilterPressed,
  });

  @override
  _HomeScreenRecipesViewState createState() => _HomeScreenRecipesViewState();
}

class _HomeScreenRecipesViewState extends State<HomeScreenRecipesView> {
  @override
  Widget build(BuildContext context) {
    final recipes = widget.presenter.getFilteredRecipes().take(6).toList(); 

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: widget.onFilterPressed,
          ),
        ],
      ),
      body: ListView(
        children: recipes.map((recipe) => _buildRecipeCard(context, recipe)).toList(),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Recipe recipe) {
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
        trailing: IconButton(

          //heart
          icon: Icon(
            recipe.favOrNah ? Icons.favorite : Icons.favorite_border,
            color: recipe.favOrNah ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              recipe.favOrNah = !recipe.favOrNah;//opposite of what it was
              if (recipe.favOrNah) {
                widget.profilePresenter.userModel.favoriteRecipes.add(recipe);
              } else {
                widget.profilePresenter.userModel.favoriteRecipes.remove(recipe);
              }
            });
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsView(recipe: recipe),
            ),
          );
        },
      ),
    );
  }
}
