import 'package:flutter/material.dart';
import '../presenters/filter_presenter.dart';

class FilterView extends StatefulWidget {
  final FilterPresenter presenter;

  FilterView({required this.presenter});

  @override
  FilterViewState createState() => FilterViewState();
}

class FilterViewState extends State<FilterView> {
  Set<String> selectedFilters = {}; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            creatingSectionTitle("Cook Time"),
            createFilterButton(["Low (30 min or less)", "Medium (1 hour or less)", "High (More than 1 hour)"]),
            creatingSectionTitle("Carbohydrates Range"),
            createFilterButton(["Low (10 grams or less)", "Medium (20 grams or less)", "High (30 grams or less) **Warning"]),
            creatingSectionTitle("Sugar Range"),
            createFilterButton(["Low (5 grams or less)", "Low (10 grams or less)", "High (15 grams or less) **Warning"]),
            creatingSectionTitle("Cuisine"),
            createFilterButton(["American", "East Asian", "Mexican", "Indian", "Italian", "Middle Eastern"]),
          ],
        ),
      ),
    );
  }

  Widget creatingSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget createFilterButton(List<String> options) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedFilters.contains(option);
        return ElevatedButton(
          onPressed: () {
            setState(() {
              if (isSelected) {
                selectedFilters.remove(option);
              } else {
                selectedFilters.add(option); // Select filter
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            foregroundColor: isSelected ? Colors.white : Colors.black,
          ),
          child: Text(option),
        );
      }).toList(),
    );
  }
}
