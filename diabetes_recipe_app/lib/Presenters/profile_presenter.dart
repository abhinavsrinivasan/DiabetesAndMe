// profile_view_presenter.dart

import '../models/user_model.dart';

class ProfilePresenter {
  final UserModel userModel;

  ProfilePresenter(this.userModel);

  // Methods for profileHealth_view
  Map<String, String> displayHealthStats() {
    return userModel.healthInformation;
  }

  void updateExerciseProgress(int exerciseCount) {
    userModel.healthInformation['Exercise Progress'] = '$exerciseCount sessions';
  }

  void editHealthStats(String key, String value) {
    userModel.healthInformation[key] = value;
  }

  // Method for profileFavorites_view
  List<String> displayFavoriteRecipes() {
    return userModel.favoriteRecipes;
  }

  // Retrieve remaining meals and exercises
  Map<String, int> displayReminders() {
    return {
      'remainingMeals': userModel.remainingMeals,
      'remainingExercises': userModel.remainingExercises,
    };
  }

  // Set daily goals for meals and exercises
  void setDailyGoals(int meals, int exercises) {
    userModel.dailyMealsGoal = meals;
    userModel.dailyExercisesGoal = exercises;
    userModel.remainingMeals = meals;
    userModel.remainingExercises = exercises;
  }

  // Decrement remaining meals
  void decrementMeals() {
    if (userModel.remainingMeals > 0) {
      userModel.remainingMeals -= 1;
    }
  }

  // Decrement remaining exercises
  void decrementExercises() {
    if (userModel.remainingExercises > 0) {
      userModel.remainingExercises -= 1;
    }
  }
}
