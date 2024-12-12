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
}
