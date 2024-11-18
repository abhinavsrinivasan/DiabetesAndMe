// user_model.dart

import 'package:flutter/material.dart';

class UserModel {
  String name;
  int age;
  String bio;
  ImageProvider profilePicture;
  Map<String, String> healthInformation;
  List<String> favoriteRecipes;

  // Reminder properties
  int dailyMealsGoal;
  int dailyExercisesGoal;
  int remainingMeals;
  int remainingExercises;

  // Constructor
  UserModel({
    required this.name,
    required this.age,
    required this.bio,
    required this.profilePicture,
    required this.healthInformation,
    required this.favoriteRecipes,
    this.dailyMealsGoal = 0,
    this.dailyExercisesGoal = 0,
    this.remainingMeals = 0,
    this.remainingExercises = 0,
  });
}
