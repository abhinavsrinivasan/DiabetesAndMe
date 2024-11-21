//child

import 'package:flutter/material.dart';
import '../presenters/profile_presenter.dart';

class FavoritesView extends StatelessWidget {
  final ProfilePresenter presenter;

  FavoritesView({required this.presenter});

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = presenter.userModel.favoriteRecipes;


    //favorites page format
    return favoriteRecipes.isEmpty
        ? Center(child: Text("No favorites yet"))
        : ListView(
            children: favoriteRecipes.map((recipe) {
              return Column(
                children: [
                  Image.asset(
                    recipe.imagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    recipe.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
  }
}
