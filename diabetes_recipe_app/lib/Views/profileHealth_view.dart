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
  int _selectedIndex = 0; // Default to Health Information tab
  bool isEditing = false; // Toggles edit mode
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for editing Health Information
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
          _buildTabBar(),
          Expanded(child: views[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabButton('Health Info', 0),
        _buildTabButton('Favorites', 1),
        _buildTabButton('Reminders', 2),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    return ElevatedButton(
      onPressed: () => setState(() => _selectedIndex = index),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedIndex == index ? Colors.blue : Colors.grey,
      ),
      child: Text(title),
    );
  }

  Widget _buildHealthInfoView() {
    final healthStats = widget.presenter.displayHealthStats();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...healthStats.keys.map((key) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: isEditing
                  ? TextField(
                      controller: controllers[key],
                      decoration: InputDecoration(labelText: key),
                    )
                  : Text(
                      "$key: ${healthStats[key]}",
                      style: TextStyle(fontSize: 16),
                    ),
            );
          }).toList(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (isEditing) {
                  controllers.forEach((key, controller) {
                    widget.presenter.editHealthStats(key, controller.text);
                  });
                }
                isEditing = !isEditing;
              });
            },
            child: Text(isEditing ? "Save" : "Edit"),
          ),
        ],
      ),
    );
  }
}
