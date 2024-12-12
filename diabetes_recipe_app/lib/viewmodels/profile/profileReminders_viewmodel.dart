import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';

class ProfileRemindersViewModel extends ChangeNotifier {
  final UserModel _userModel;

  // Constructor correctly initializes _userModel
  ProfileRemindersViewModel({required UserModel userModel}) : _userModel = userModel;

  int get remainingMeals => _userModel.remainingMeals;
  int get remainingExercises => _userModel.remainingExercises;

  Map<String, int> displayReminders() {
    return {
      'remainingMeals': _userModel.remainingMeals,
      'remainingExercises': _userModel.remainingExercises,
    };
  }

  void setGoals(int meals, int exercises) {
    _userModel.dailyMealsGoal = meals;
    _userModel.dailyExercisesGoal = exercises;
    _userModel.remainingMeals = meals;
    _userModel.remainingExercises = exercises;
    notifyListeners();
  }

  void decrementMeals() {
    if (_userModel.remainingMeals > 0) {
      _userModel.remainingMeals--;
      notifyListeners();
    }
  }

  void decrementExercises() {
    if (_userModel.remainingExercises > 0) {
      _userModel.remainingExercises--;
      notifyListeners();
    }
  }
}
