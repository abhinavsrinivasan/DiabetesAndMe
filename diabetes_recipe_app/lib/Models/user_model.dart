//

import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class UserModel {
  String name;
  int age;
  String bio;
  ImageProvider profilePicture;
  Map<String, String> healthInformation;
  List<Recipe> favoriteRecipes = [];

  int dailyMealsGoal;
  int dailyExercisesGoal;
  int remainingMeals;
  int remainingExercises;

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
