import 'package:flutter/material.dart';
import '../Presenters/filter_presenter.dart';
import '../Models/recipe_model.dart';

class FilterView extends StatefulWidget {
  final FilterPresenter presenter;

  FilterView({required this.presenter});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  int selectedCookTime = 30;
  int minCarbs = 0, maxCarbs = 100;
  int minSugar = 0, maxSugar = 50;
  String selectedCuisine = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter Recipes')),
      body: Column(
        children: [
          // Filter Options (e.g., Slider for Cook Time)
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
          DropdownButton<String>(
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
          ElevatedButton(
            onPressed: () {
              widget.presenter.applyCookTimeFilter(selectedCookTime);
              if (selectedCuisine != 'All') {
                widget.presenter.applyCuisineFilter(selectedCuisine);
              }
              setState(() {});
            },
            child: Text('Apply Filters'),
          ),
          // Display Filtered Recipes
          Expanded(
            child: ListView.builder(
              itemCount: widget.presenter.getFilteredRecipes().length,
              itemBuilder: (context, index) {
                final recipe = widget.presenter.getFilteredRecipes()[index];
                return ListTile(
                  title: Text(recipe.title),
                  subtitle: Text("Cuisine: ${recipe.cuisine}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}