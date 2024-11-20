//child

import 'package:flutter/material.dart';
import '../presenters/profile_presenter.dart';

class HealthInfoView extends StatefulWidget {
  final ProfilePresenter presenter;

  HealthInfoView({required this.presenter});

  @override
  _HealthInfoViewState createState() => _HealthInfoViewState();
}

class _HealthInfoViewState extends State<HealthInfoView> {
  bool editingOrNah = false; // Toggles edit mode
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each health statistic
    controllers = widget.presenter.showHealthData().map((key, value) {
      return MapEntry(key, TextEditingController(text: value));
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthStats = widget.presenter.showHealthData();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var entry in healthStats.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: editingOrNah
                  ? TextField(
                      controller: controllers[entry.key],
                      decoration: InputDecoration(labelText: entry.key),
                    )
                  : Text(
                      "${entry.key}: ${entry.value}",
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (editingOrNah) {
                  controllers.forEach((key, controller) {
                    widget.presenter.editHealthData(key, controller.text);
                  });
                }
                editingOrNah = !editingOrNah;
              });
            },
            child: Text(editingOrNah ? "Save" : "Edit"),
          ),
        ],
      ),
    );
  }
}
