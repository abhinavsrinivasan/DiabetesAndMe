import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class UserModel {
  String name;
  int age;
  String bio;
  ImageProvider profilePicture;
  Map<String, String> healthInformation;
  List<Recipe> favoriteRecipes;

  int dailyMealsGoal;
  int dailyExercisesGoal;
  int remainingMeals;
  int remainingExercises;

  int consumedCarbs; // Tracks the carbs consumed
  int consumedSugar; // Tracks the sugar consumed

  UserModel({
    required this.name,
    required this.age,
    required this.bio,
    required this.profilePicture,
    required this.healthInformation,
    this.favoriteRecipes = const [],
    this.dailyMealsGoal = 0,
    this.dailyExercisesGoal = 0,
    this.remainingMeals = 0,
    this.remainingExercises = 0,
    this.consumedCarbs = 0, // Initializes with zero carbs consumed
    this.consumedSugar = 0, // Initializes with zero sugar consumed
  });

  void addNutritionalInfo(int carbs, int sugar) {
    consumedCarbs += carbs;
    consumedSugar += sugar;
  }

  void resetNutritionalInfo() {
    consumedCarbs = 0;
    consumedSugar = 0;
  }
}
