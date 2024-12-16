//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';
import 'profileFavorites_view.dart';
import 'profileReminders_view.dart';
import 'profileHealth_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    final views = [
      HealthInfoView(),
      FavoritesView(),
      RemindersView(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20, 
              backgroundImage: viewModel.profilePicture,
            ),
            SizedBox(width: 8),
            Text(viewModel.userName),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => viewModel.settabNum(0),
                child: Text("Health Info"),
              ),
              ElevatedButton(
                onPressed: () => viewModel.settabNum(1),
                child: Text("Favorites"),
              ),
              ElevatedButton(
                onPressed: () => viewModel.settabNum(2),
                child: Text("Reminders"),
              ),
            ],
          ),
          Expanded(child: views[viewModel.currenttabNum]),
        ],
      ),
    );
  }
}
