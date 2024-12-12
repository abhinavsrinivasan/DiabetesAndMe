import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';
import '../../viewmodels/home/recipe_details_viewmodel.dart';

class RecipeDetailsView extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeDetailsViewModel(recipe: recipe),
      child: Consumer<RecipeDetailsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(viewModel.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("Cuisine: ${viewModel.cuisine}", style: TextStyle(fontSize: 16)),
                  Text("Cook Time: ${viewModel.cookTime} mins", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text(
                    "Nutritional Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Carbs: ${viewModel.carbRange} grams"),
                  Text("Sugar: ${viewModel.sugarRange} grams"),
                  SizedBox(height: 10),
                  Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var ingredient in viewModel.ingredients)
                    Text("- $ingredient"),
                  SizedBox(height: 10),
                  Text(
                    "Preparation Steps",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var step in viewModel.preparationSteps)
                    Text("- $step"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
