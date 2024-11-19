import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'models/recipe_model.dart'; // Consistent lowercase import
import 'presenters/profile_presenter.dart';
import 'presenters/filter_presenter.dart'; // Consistent lowercase import
import 'views/profileHealth_view.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserModel userModel = UserModel(
    name: "John Doe",
    age: 30,
    bio: "Managing Type 2 Diabetes",
    profilePicture: AssetImage("assets/images/profile.png"),
    healthInformation: {
      "Diabetes Type": "Type 2 Diabetes",
      "Target Blood Sugar": "70-130 mg/dL",
      "Daily Carb Goal": "30-40 grams per meal",
    },
    favoriteRecipes: ["Feta Pasta", "Chicken Salad", "Avocado Toast"],
    dailyMealsGoal: 3,
    dailyExercisesGoal: 2,
    remainingMeals: 3,
    remainingExercises: 2,
  );

  final List<Recipe> recipeList = [
    Recipe(
      title: "Feta Pasta",
      cuisine: "Italian",
      cookTime: 25,
      macros: {"carbs": 20, "sugar": 5},
      ingredients: ["Pasta", "Feta Cheese", "Tomatoes"],
      preparationSteps: [
        "Step 1: Boil pasta.",
        "Step 2: Add feta and tomatoes.",
        "Step 3: Bake for 20 minutes."
      ],
    ),
    Recipe(
      title: "Chicken Salad",
      cuisine: "American",
      cookTime: 15,
      macros: {"carbs": 10, "sugar": 2},
      ingredients: ["Chicken", "Lettuce", "Dressing"],
      preparationSteps: [
        "Step 1: Grill chicken.",
        "Step 2: Toss lettuce with dressing.",
        "Step 3: Combine chicken with lettuce."
      ],
    ),
    Recipe(
      title: "Avocado Toast",
      cuisine: "Mexican",
      cookTime: 10,
      macros: {"carbs": 30, "sugar": 4},
      ingredients: ["Avocado", "Bread", "Salt"],
      preparationSteps: [
        "Step 1: Toast bread.",
        "Step 2: Mash avocado and spread on bread.",
        "Step 3: Sprinkle with salt."
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final profilePresenter = ProfilePresenter(userModel);
    final filterPresenter = FilterPresenter(recipeList); // Pass the recipe list

    return MaterialApp(
      title: 'Diabetes Recipe App',
      home: MainPage(profilePresenter: profilePresenter, filterPresenter: filterPresenter),
    );
  }
}

class MainPage extends StatefulWidget {
  final ProfilePresenter profilePresenter;
  final FilterPresenter filterPresenter;

  MainPage({required this.profilePresenter, required this.filterPresenter});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // Default to Home tab

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Center(child: Text("Social Media")), // Placeholder for Social Media page
      HomeView(presenter: widget.filterPresenter), // Pass FilterPresenter to HomeView
      ProfileView(presenter: widget.profilePresenter), // Pass ProfilePresenter to ProfileView
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Social Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
