import 'package:flutter/material.dart';
import '../presenters/profile_presenter.dart';

class FavoritesView extends StatelessWidget {
  final ProfilePresenter presenter;

  FavoritesView({required this.presenter});

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = presenter.displayFavoriteRecipes();

    return ListView.builder(
      itemCount: favoriteRecipes.length,
      itemBuilder: (context, index) {
        final recipeName = favoriteRecipes[index];
        final imagePath = 'assets/images/${recipeName.replaceAll(' ', '')}.jpg'; // Map directly to file name
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the image for the recipe
              Image.asset(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              // Display the recipe name centered
              Text(
                recipeName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
