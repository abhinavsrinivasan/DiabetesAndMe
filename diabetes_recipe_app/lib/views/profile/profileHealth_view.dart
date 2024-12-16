import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile/profileHealth_viewmodel.dart';

class HealthInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileHealthViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //nutriotion infor
          Text(
            "Nutritional Info",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nutritionalInfo(
                  "Carbs", viewModel.consumedCarbs, viewModel.addCarbs, context),
              nutritionalInfo(
                  "Sugar", viewModel.consumedSugar, viewModel.addSugar, context),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: goalInfo(
                  "Carb Goal",
                  viewModel.carbGoalController,
                  "grams",
                  (goal) => viewModel.setCarbGoal(goal),
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: goalInfo(
                  "Sugar Goal",
                  viewModel.sugarGoalController,
                  "grams",
                  (goal) => viewModel.setSugarGoal(goal),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          //health information
          Text(
            "Health Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          for (var entry in viewModel.healthData.entries)
            if (viewModel.isEditing)
              TextField(
                controller: viewModel.controllers[entry.key],
                decoration: InputDecoration(labelText: entry.key),
              )
            else
              Text(
                "${entry.key}: ${entry.value}",
                style: TextStyle(fontSize: 16),
              ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.toggleEditing,
            child: Builder(
              builder: (context) {
                if (viewModel.isEditing) {
                  return Text("Save");
                } else {
                  return Text("Edit");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget nutritionalInfo(
      String label, int value, Function(int) onAdd, BuildContext context) {
    return Row(
      children: [
        Text("$label: $value", style: TextStyle(fontSize: 16)),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => displayNutrition(context, label, onAdd),
        ),
      ],
    );
  }

  Widget goalInfo(String label, TextEditingController controller, String unit,
      Function(int) onUpdate) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              suffixText: unit,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final goal = int.tryParse(value) ?? 0;
              onUpdate(goal);
            },
          ),
        ),
      ],
    );
  }

  void displayNutrition(
      BuildContext parentContext, String nutrient, Function(int) onAdd) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Add $nutrient"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "$nutrient (grams)"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text) ?? 0;
                onAdd(value);
                Navigator.of(dialogContext).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
