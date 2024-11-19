import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../presenters/filter_presenter.dart';

class HomeScreenRecipesView extends StatelessWidget {
  final FilterPresenter presenter;

  HomeScreenRecipesView({required this.presenter});

  @override
  Widget build(BuildContext context) {
    // Get the first six recipes or fewer if the list is smaller
    final recipes = presenter.getFilteredRecipes().take(6).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.restaurant_menu, size: 40), // Placeholder for an image
              title: Text(recipe.title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Cuisine: ${recipe.cuisine}\nCook Time: ${recipe.cookTime} mins"),
              onTap: () {
                // Navigate to a detailed recipe page (optional placeholder)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailsView(recipe: recipe),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// A simple placeholder for the detailed recipe view
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
            Text(
              recipe.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Cuisine: ${recipe.cuisine}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Cook Time: ${recipe.cookTime} mins", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text("Ingredients:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (var ingredient in recipe.ingredients)
              Text("- $ingredient", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text("Preparation Steps:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (var step in recipe.preparationSteps)
              Text("- $step", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
