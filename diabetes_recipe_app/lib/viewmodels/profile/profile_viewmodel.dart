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

  Map<String, int> displayReminders() {
    return {
      'remainingMeals': userModel.remainingMeals,
      'remainingExercises': userModel.remainingExercises,
    };
  }

  //ensure meals is same for dailyMealsgoal and remainingMeals to begin with and exercises for other
  void setGoals(int meals, int exercises) {
    userModel.dailyMealsGoal = meals;
    userModel.dailyExercisesGoal = exercises;
    userModel.remainingMeals = meals;
    userModel.remainingExercises = exercises;
  }

  //meal decrement
  void decrementMeals() {
    if (userModel.remainingMeals > 0) {
      userModel.remainingMeals--;
    }
  }

  //exercise decrement
  void decrementExercises() {
    if (userModel.remainingExercises > 0) {
      userModel.remainingExercises--;
    }
  }
}
