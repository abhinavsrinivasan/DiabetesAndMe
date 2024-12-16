import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class ProfileHealthViewModel extends ChangeNotifier {
  final UserModel _userModel;
  bool _isEditing = false;

    //controllers for different parameters
  final Map<String, TextEditingController> controllers = {};
  final TextEditingController carbGoalController = TextEditingController();
  final TextEditingController sugarGoalController = TextEditingController();

  ProfileHealthViewModel({required UserModel userModel})
      : _userModel = userModel {
    _initializeControllers();
  }

  bool get isEditing => _isEditing;

  Map<String, String> get healthData => _userModel.healthInformation;

  int get consumedCarbs => _userModel.consumedCarbs;
  int get consumedSugar => _userModel.consumedSugar;

  int get carbGoal => _userModel.carbGoal;
  int get sugarGoal => _userModel.sugarGoal;

    //initialize
  void _initializeControllers() {
    _userModel.healthInformation.forEach((key, value) {
      controllers[key] = TextEditingController(text: value);
    });

    carbGoalController.text = (_userModel.carbGoal).toString();
    sugarGoalController.text = (_userModel.sugarGoal).toString();
  }

  void toggleEditing() {
    if (_isEditing) {
      controllers.forEach((key, controller) {
        _userModel.healthInformation[key] = controller.text;
      });
    }
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void addCarbs(int value) {
    _userModel.consumedCarbs += value;
    notifyListeners();
  }

  void addSugar(int value) {
    _userModel.consumedSugar += value;
    notifyListeners();
  }

  void setCarbGoal(int goal) {
    _userModel.carbGoal = goal;
    notifyListeners();
  }

  void setSugarGoal(int goal) {
    _userModel.sugarGoal = goal;
    notifyListeners();
  }
}
