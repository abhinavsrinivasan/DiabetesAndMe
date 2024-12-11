//child

import 'package:flutter/material.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';

class HealthInfoView extends StatefulWidget {
  final ProfilePresenter presenter;

  HealthInfoView({required this.presenter});

  @override
  HealthInfoViewState createState() => HealthInfoViewState();
}

class HealthInfoViewState extends State<HealthInfoView> {
  bool editingOrNah = false; 
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    controllers = widget.presenter.showHealthData().map((key, value) {
      return MapEntry(key, TextEditingController(text: value));
    });
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
