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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Cuisine: ${recipe.cuisine}"),
            Text("Cook Time: ${recipe.cookTime} mins"),
            Text("Carbs: ${recipe.carbRange} grams"),
            Text("Sugar: ${recipe.sugarRange} grams"),
            SizedBox(height: 10),
            Text("Ingredients:"),
            for (var ingredient in recipe.ingredients) Text("- $ingredient"),
            SizedBox(height: 10),
            Text("Steps:"),
            for (var step in recipe.preparationSteps) Text("- $step"),
          ],
        ),
      ),
    );
  }
}
