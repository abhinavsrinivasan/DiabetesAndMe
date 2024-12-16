import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/filter/filter_viewmodel.dart';

class FilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FilterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Added Scrollable Widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var section in filterButtons)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        section['title'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: section['options'].map<Widget>((option) {
                        final isSelected =
                            viewModel.isFilterSelected(section['category'], option);

                        return ElevatedButton(
                          onPressed: () =>
                              viewModel.toggleFilter(section['category'], option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                            foregroundColor: isSelected ? Colors.white : Colors.black,
                          ),
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      viewModel.resetFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.applyFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Apply"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> filterButtons = [
    {
      'title': "Cook Time",
      'options': ["Low (30 min or less)", "Medium (1 hour or less)", "High (More than 1 hour)"],
      'category': "cookTime",
    },
    {
      'title': "Carbohydrates Range",
      'options': [
        "Low (10 grams or less)",
        "Medium (20 grams or less)",
        "High (30 grams or less) **Warning"
      ],
      'category': "carbs",
    },
    {
      'title': "Sugar Range",
      'options': [
        "Low (5 grams or less)",
        "Medium (10 grams or less)",
        "High (15 grams or less) **Warning"
      ],
      'category': "sugar",
    },
    {
      'title': "Cuisine",
      'options': ["American", "Asian", "Mexican", "Mediterranean", "Italian", "Middle Eastern"],
      'category': "cuisine",
    },
  ];
}
