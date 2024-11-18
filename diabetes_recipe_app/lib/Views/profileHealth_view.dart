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
  void dispose() {
    // Dispose controllers to free memory
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildCurrentView()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildTabBar() {
    const tabs = ['Health Info', 'Favorites', 'Reminders'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        return ElevatedButton(
          onPressed: () => setState(() => _selectedIndex = index),
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedIndex == index ? Colors.blue : Colors.grey,
          ),
          child: Text(tabs[index]),
        );
      }),
    );
  }

  Widget _buildCurrentView() {
    switch (_selectedIndex) {
      case 0:
        return _buildHealthInfoView();
      case 1:
        return FavoritesView(presenter: widget.presenter);
      case 2:
        return RemindersView(presenter: widget.presenter);
      default:
        return _buildHealthInfoView();
    }
  }

  Widget _buildHealthInfoView() {
    final healthStats = widget.presenter.displayHealthStats();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...healthStats.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: isEditing
                  ? TextField(
                      controller: controllers[entry.key],
                      decoration: InputDecoration(labelText: entry.key),
                    )
                  : Text(
                      "${entry.key}: ${entry.value}",
                      style: TextStyle(fontSize: 16),
                    ),
            );
          }).toList(),
          SizedBox(height: 16),
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
