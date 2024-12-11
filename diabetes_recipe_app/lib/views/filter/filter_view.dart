import 'package:flutter/material.dart';
import '../../viewmodels/filter/filter_viewmodel.dart';


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
            createFilterButton(["Low (5 grams or less)", "Medium (10 grams or less)", "High (15 grams or less) **Warning"]),
            creatingSectionTitle("Cuisine"),
            createFilterButton(["American", "Asian", "Mexican", "Indian", "Italian", "Middle Eastern"]),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.presenter.resetFilters();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    //filtering logic
                    String? selectedCuisine;
                    if (selectedFilters.contains("American")) selectedCuisine = "American";
                    if (selectedFilters.contains("Asian")) selectedCuisine = "Asian"; 
                    if (selectedFilters.contains("Mexican")) selectedCuisine = "Mexican";
                    if (selectedFilters.contains("Indian")) selectedCuisine = "Indian";
                    if (selectedFilters.contains("Italian")) selectedCuisine = "Italian";
                    if (selectedFilters.contains("Middle Eastern")) selectedCuisine = "Middle Eastern";

                    int? maxCookTime;
                    if (selectedFilters.contains("Low (30 min or less)")) maxCookTime = 30;
                    if (selectedFilters.contains("Medium (1 hour or less)")) maxCookTime = 60;

                    int? maxCarbRange;
                    if (selectedFilters.contains("Low (10 grams or less)")) maxCarbRange = 10;
                    if (selectedFilters.contains("Medium (20 grams or less)")) maxCarbRange = 20;

                    int? maxSugarRange;
                    if (selectedFilters.contains("Low (5 grams or less)")) maxSugarRange = 5;
                    if (selectedFilters.contains("Medium (10 grams or less)")) maxSugarRange = 10;

                    widget.presenter.applyFilters(
                      cuisine: selectedCuisine,
                      maxCookTime: maxCookTime,
                      maxCarbRange: maxCarbRange,
                      maxSugarRange: maxSugarRange,
                    );

 
                    setState(() {});

                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Apply"),
                ),
              ],
            ),
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
                selectedFilters.add(option);
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
