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
        return ListTile(
          leading: Icon(Icons.restaurant),
          title: Text(favoriteRecipes[index]),
        );
      },
    );
  }
}


