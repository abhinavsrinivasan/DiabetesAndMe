import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile/profileFavorites_viewmodel.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use the ViewModel provided via Provider
    final favoritesViewModel = Provider.of<ProfileFavoritesViewModel>(context);

    final favoriteRecipes = favoritesViewModel.favoriteRecipes;

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
