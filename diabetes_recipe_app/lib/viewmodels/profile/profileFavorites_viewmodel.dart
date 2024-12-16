//

import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';
import '../../models/recipe_model.dart';

class ProfileFavoritesViewModel extends ChangeNotifier {
  final UserModel _userModel;

  ProfileFavoritesViewModel({required UserModel userModel}) : _userModel = userModel;

  List<Recipe> get favoriteRecipes => _userModel.favoriteRecipes;
}
