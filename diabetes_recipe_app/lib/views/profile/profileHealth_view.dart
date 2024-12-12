import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile/profileHealth_viewmodel.dart';

class HealthInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileHealthViewModel>(context);

    final healthStats = viewModel.healthData;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nutritional Info Section
          Text(
            "Nutritional Info",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Carbs: ${viewModel.consumedCarbs}", style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showNutritionalInputDialog(context, "Carbs", viewModel.addCarbs);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Sugar: ${viewModel.consumedSugar}", style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showNutritionalInputDialog(context, "Sugar", viewModel.addSugar);
                    },
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 30, thickness: 2),

          // Original Health Information Section
          Text(
            "Health Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          for (var entry in healthStats.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: viewModel.isEditing
                  ? TextField(
                      controller: viewModel.controllers[entry.key],
                      decoration: InputDecoration(labelText: entry.key),
                    )
                  : Text(
                      "${entry.key}: ${entry.value}",
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.toggleEditing,
            child: Text(viewModel.isEditing ? "Save" : "Edit"),
          ),
        ],
      ),
    );
  }

  void _showNutritionalInputDialog(
      BuildContext context, String nutrient, Function(int) onAdd) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Add $nutrient"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "$nutrient (grams)"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text) ?? 0;
                onAdd(value);
                Navigator.of(ctx).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
