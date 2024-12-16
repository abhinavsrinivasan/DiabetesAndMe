//

import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';

class ProfileRemindersViewModel extends ChangeNotifier {
  final UserModel _userModel;

  ProfileRemindersViewModel({required UserModel userModel}) : _userModel = userModel;


//variables for health tracking
  int get remainingMeals => _userModel.remainingMeals;
  int get remainingExercises => _userModel.remainingExercises;


  Map<String, int> displayReminders() {
    return {
      'remainingMeals': _userModel.remainingMeals,
      'remainingExercises': _userModel.remainingExercises,
    };
  }

    //decrement meals in reminder bar calculation
  void decrementMeals() {
    if (_userModel.remainingMeals > 0) {
      _userModel.remainingMeals--;
      notifyListeners();
    }
  }

    //decrement exercises in reminder bar calculation
  void decrementExercises() {
    if (_userModel.remainingExercises > 0) {
      _userModel.remainingExercises--;
      notifyListeners();
    }
  }
}
