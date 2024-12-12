//

import '../../models/user_model.dart';
import '../../models/recipe_model.dart';

class ProfilePresenter {
  final UserModel userModel;

  ProfilePresenter(this.userModel);

  Map<String, String> showHealthData() {
    return userModel.healthInformation;
  }

  void editHealthData(String key, String value) {
    userModel.healthInformation[key] = value;
  }

  //filter by when "favOrNah == true"
  List<Recipe> showFavoriteRecipies() {
  return userModel.favoriteRecipes.where((recipe) => recipe.favOrNah).toList();
} 
}
