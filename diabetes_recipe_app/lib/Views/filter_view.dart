import 'package:flutter/material.dart';
import '../presenters/filter_presenter.dart';
import '../models/recipe_model.dart';

class FilterView extends StatefulWidget {
  final FilterPresenter presenter;

  FilterView({required this.presenter});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  int selectedCookTime = 30; // Default cook time filter
  String selectedCuisine = 'All'; // Default cuisine filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Recipes'),
      ),
      body: Column(
        children: [
          // Cook Time Slider
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cook Time: $selectedCookTime mins', style: TextStyle(fontSize: 16)),
                Slider(
                  value: selectedCookTime.toDouble(),
                  min: 0,
                  max: 120,
                  divisions: 12,
                  label: "$selectedCookTime mins",
                  onChanged: (value) {
                    setState(() {
                      selectedCookTime = value.toInt();
                    });
                  },
                ),
              ],
            ),
          ),
          // Cuisine Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCuisine,
              items: ['All', 'Italian', 'Chinese', 'Mexican'].map((cuisine) {
                return DropdownMenuItem(value: cuisine, child: Text(cuisine));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCuisine = value!;
                });
              },
            ),
          ),
          // Apply Filters Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Apply filters using the presenter
                widget.presenter.applyCookTimeFilter(selectedCookTime);
                if (selectedCuisine != 'All') {
                  widget.presenter.applyCuisineFilter(selectedCuisine);
                } else {
                  widget.presenter.resetFilters();
                }
                setState(() {}); // Refresh the filtered list
              },
              child: Text('Apply Filters'),
            ),
          ),
          // Display Filtered Recipes
          Expanded(
            child: ListView.builder(
              itemCount: widget.presenter.getFilteredRecipes().length,
              itemBuilder: (context, index) {
                final recipe = widget.presenter.getFilteredRecipes()[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(recipe.title),
                    subtitle: Text("Cuisine: ${recipe.cuisine}\nCook Time: ${recipe.cookTime} mins"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
