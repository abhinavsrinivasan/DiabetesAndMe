//

import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/recipe_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserModel _userModel;

  int tabNum = 0;

  ProfileViewModel({required UserModel userModel}) : _userModel = userModel;

//user data
  String get userName => _userModel.name;
  ImageProvider get profilePicture => _userModel.profilePicture;
  Map<String, String> get healthInformation => _userModel.healthInformation;

  int get currenttabNum => tabNum;

  void settabNum(int index) {
    tabNum = index;
    notifyListeners();
  }

//filtering favorite recipes
  List<Recipe> get favoriteRecipes =>
      _userModel.favoriteRecipes.where((recipe) => recipe.favOrNah).toList();
}
