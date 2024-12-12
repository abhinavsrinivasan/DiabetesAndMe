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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _creatingSectionTitle("Cook Time"),
            _createFilterButton(viewModel, ["Low (30 min or less)", "Medium (1 hour or less)", "High (More than 1 hour)"], "cookTime"),
            _creatingSectionTitle("Carbohydrates Range"),
            _createFilterButton(viewModel, ["Low (10 grams or less)", "Medium (20 grams or less)", "High (30 grams or less) **Warning"], "carbs"),
            _creatingSectionTitle("Sugar Range"),
            _createFilterButton(viewModel, ["Low (5 grams or less)", "Medium (10 grams or less)", "High (15 grams or less) **Warning"], "sugar"),
            _creatingSectionTitle("Cuisine"),
            _createFilterButton(viewModel, ["American", "Asian", "Mexican", "Indian", "Italian", "Middle Eastern"], "cuisine"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    viewModel.resetFilters();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.applyFilters();
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

  Widget _creatingSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createFilterButton(FilterViewModel viewModel, List<String> options, String category) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = viewModel.isFilterSelected(category, option);
        return ElevatedButton(
          onPressed: () {
            viewModel.toggleFilter(category, option);
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
