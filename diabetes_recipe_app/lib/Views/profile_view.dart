//parent view - manages navigation and layout

import 'package:flutter/material.dart';
import '../presenters/profile_presenter.dart';
import 'profileFavorites_view.dart';
import 'profileReminders_view.dart';
import 'profileHealth_view.dart'; 

class ProfileView extends StatefulWidget {
  final ProfilePresenter presenter;

  ProfileView({required this.presenter});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int varIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    final views = [
      HealthInfoView(presenter: widget.presenter), 
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              final titles = ['Health Info', 'Favorites', 'Reminders'];
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    varIndex = index;
                  });
                },
                child: Text(
                  titles[index],
                  style: TextStyle(
                    fontWeight: varIndex == index ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }),
          ),
          Expanded(child: views[varIndex]),
        ],
      ),
    );
  }
}
