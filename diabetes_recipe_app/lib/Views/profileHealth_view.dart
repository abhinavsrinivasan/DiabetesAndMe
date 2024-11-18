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
  late List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _views = [
      HealthInformationView(presenter: widget.presenter), // Health Info
      FavoritesView(presenter: widget.presenter),         // Favorites
      RemindersView(presenter: widget.presenter),         // Reminders
    ];
  }

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index for the buttons
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: Column(
        children: [
          _buildButtonBar(), // Top button bar
          Expanded(
            child: _views[_selectedIndex], // Display selected view
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildHeader() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          SizedBox(height: 20), // Space above profile picture
          CircleAvatar(
            radius: 40,
            backgroundImage: widget.presenter.userModel.profilePicture,
          ),
          SizedBox(height: 16), // Space between picture and name
          Text(
            widget.presenter.userModel.name,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      centerTitle: true,
      toolbarHeight: 150, // Increased height to move profile picture down
      backgroundColor: Colors.transparent, // Optional: Transparent AppBar
      elevation: 0, // Remove shadow
    );
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('Health Info', 0),
        _buildButton('Favorites', 1),
        _buildButton('Reminders', 2),
      ],
    );
  }

  Widget _buildButton(String title, int index) {
    return ElevatedButton(
      onPressed: () {
        _onButtonTapped(index);
      },
      child: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.white : Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class HealthInformationView extends StatelessWidget {
  final ProfilePresenter presenter;

  HealthInformationView({required this.presenter});

  @override
  Widget build(BuildContext context) {
    final healthStats = presenter.displayHealthStats();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: healthStats.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${entry.key}: ${entry.value}',
              style: TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ),
    );
  }
}
