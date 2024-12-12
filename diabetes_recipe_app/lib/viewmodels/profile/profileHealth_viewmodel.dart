import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class ProfileHealthViewModel extends ChangeNotifier {
  final UserModel _userModel;
  bool _isEditing = false;

  // Controllers for text fields
  final Map<String, TextEditingController> controllers = {};

  ProfileHealthViewModel({required UserModel userModel})
      : _userModel = userModel {
    _initializeControllers();
  }

  bool get isEditing => _isEditing;

  Map<String, String> get healthData => _userModel.healthInformation;

  void _initializeControllers() {
    _userModel.healthInformation.forEach((key, value) {
      controllers[key] = TextEditingController(text: value);
    });
  }

  void toggleEditing() {
    if (_isEditing) {
      // Save changes
      controllers.forEach((key, controller) {
        _userModel.healthInformation[key] = controller.text;
      });
    }
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void disposeControllers() {
    // Dispose all controllers when done
    controllers.values.forEach((controller) => controller.dispose());
  }
}
