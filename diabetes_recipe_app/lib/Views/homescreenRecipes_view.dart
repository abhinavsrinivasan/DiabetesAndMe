import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../presenters/filter_presenter.dart';
import 'filter_view.dart';

class HomeScreenRecipesView extends StatelessWidget {
  final FilterPresenter presenter;
  final VoidCallback onFilterPressed;

  HomeScreenRecipesView({required this.presenter, required this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    final recipes = presenter.getFilteredRecipes().take(6).toList(); // Get filtered recipes

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: onFilterPressed, // Navigate to filter screen
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

class RecipeDetailsView extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Cuisine: ${recipe.cuisine}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Cook Time: ${recipe.cookTime} mins", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            _buildSectionTitle("Ingredients"),
            ...recipe.ingredients.map((ingredient) => Text("- $ingredient", style: TextStyle(fontSize: 16))),
            SizedBox(height: 16),
            _buildSectionTitle("Preparation Steps"),
            ...recipe.preparationSteps.map((step) => Text("- $step", style: TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
