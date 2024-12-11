//
import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';

class RecipeDetailsView extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Cuisine: ${recipe.cuisine}", style: TextStyle(fontSize: 16)),
          Text("Cook Time: ${recipe.cookTime} mins", style: TextStyle(fontSize: 16)),
          Text("Ingredients", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (var ingredient in recipe.ingredients)
            Text("- $ingredient"),
          Text("Preparation Steps", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (var step in recipe.preparationSteps)
            Text("- $step"),
        ],
      ),
    );
  }
}
