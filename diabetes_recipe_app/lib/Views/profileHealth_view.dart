import 'package:flutter/material.dart';
import '../presenters/profile_presenter.dart';
import 'profileFavorites_view.dart';
import 'profileReminders_view.dart';

class ProfileView extends StatefulWidget {
  final ProfilePresenter presenter;

  ProfileView({required this.presenter});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int varIndex = 0; // Default to Health Info tab
  bool editMode = false; // Toggles edit mode
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    widget.presenter.displayHealthStats().forEach((key, value) {
      controllers[key] = TextEditingController(text: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final views = [
      _buildHealthInfoView(),
      FavoritesView(presenter: widget.presenter),
      RemindersView(presenter: widget.presenter),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: widget.presenter.userModel.profilePicture,
            ),
            SizedBox(height: 8),
            Text(widget.presenter.userModel.name),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => varIndex = 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: varIndex == 0 ? Colors.blue : Colors.grey,
                ),
                child: Text('Health Info'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => varIndex = 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: varIndex == 1 ? Colors.blue : Colors.grey,
                ),
                child: Text('Favorites'),
              ),
              ElevatedButton(
                onPressed: () => setState(() => varIndex = 2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: varIndex == 2 ? Colors.blue : Colors.grey,
                ),
                child: Text('Reminders'),
              ),
            ],
          ),
          Expanded(child: views[varIndex]),
        ],
      ),
    );
  }

  Widget _buildHealthInfoView() {
    final healthStatistics = widget.presenter.displayHealthStats();
    final List<Widget> healthStatWidgets = [];

    // Manually add each health stat widget to the list
    healthStatistics.entries.forEach((entry) {
      healthStatWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: editMode
              ? TextField(
                  controller: controllers[entry.key],
                  decoration: InputDecoration(labelText: entry.key),
                )
              : Text(
                  "${entry.key}: ${entry.value}",
                  style: TextStyle(fontSize: 16),
                ),
        ),
      );
    });

    // Add the edit/save button
    healthStatWidgets.add(SizedBox(height: 16));
    healthStatWidgets.add(
      ElevatedButton(
        onPressed: () {
          setState(() {
            if (editMode) {
              // Save the updated values to the presenter
              controllers.forEach((key, controller) {
                widget.presenter.editHealthStats(key, controller.text);
              });
            }
            editMode = !editMode; // Toggle edit mode
          });
        },
        child: Text(editMode ? "Save" : "Edit"),
      ),
    );

    // Return the full column with all widgets
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: healthStatWidgets,
      ),
    );
  }
}
