import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'models/recipe_model.dart';
import 'presenters/profile_presenter.dart';
import 'presenters/filter_presenter.dart';
import 'views/homescreenRecipes_view.dart';
import 'views/profileHealth_view.dart';
import 'views/filter_view.dart';
import 'views/profile_view.dart';

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
    favoriteRecipes: [],
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
      imagePath: "assets/images/FetaPasta.jpg",
      favOrNah: false,
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
      imagePath: "assets/images/ChickenSalad.jpg",
      favOrNah: false,
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
      imagePath: "assets/images/AvocadoToast.jpg",
      favOrNah: false,
    ),
    Recipe(
      title: "Vegetable Stir Fry",
      cuisine: "Asian",
      cookTime: 20,
      macros: {"carbs": 15, "sugar": 3},
      ingredients: ["Broccoli", "Carrots", "Soy Sauce", "Garlic"],
      preparationSteps: [
        "Step 1: Heat oil in a pan.",
        "Step 2: Add vegetables and stir-fry for 5 minutes.",
        "Step 3: Add soy sauce and cook for another 5 minutes."
      ],
      imagePath: "assets/images/VegetableStirFry.jpg",
      favOrNah: false,
    ),
    Recipe(
      title: "Berry Smoothie",
      cuisine: "American",
      cookTime: 5,
      macros: {"carbs": 18, "sugar": 12},
      ingredients: ["Berries", "Yogurt", "Honey"],
      preparationSteps: [
        "Step 1: Combine all ingredients in a blender.",
        "Step 2: Blend until smooth.",
        "Step 3: Serve chilled."
      ],
      imagePath: "assets/images/BerrySmoothie.jpg",
      favOrNah: false,
    ),
    Recipe(
      title: "Grilled Salmon",
      cuisine: "Mediterranean",
      cookTime: 30,
      macros: {"carbs": 5, "sugar": 1},
      ingredients: ["Salmon", "Olive Oil", "Garlic", "Lemon"],
      preparationSteps: [
        "Step 1: Marinate salmon with olive oil, garlic, and lemon.",
        "Step 2: Preheat grill to medium heat.",
        "Step 3: Grill salmon for 10-15 minutes per side."
      ],
      imagePath: "assets/images/GrilledSalmon.jpg",
      favOrNah: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final profilePresenter = ProfilePresenter(userModel);
    final filterPresenter = FilterPresenter(recipeList);

    return MaterialApp(
      title: 'Diabetes Recipe App',
      home: MainPage(
        profilePresenter: profilePresenter,
        filterPresenter: filterPresenter,
      ),
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
  int _selectedIndex = 1; 

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Center(child: Text("Social Media")),
      HomeScreenRecipesView(
        presenter: widget.filterPresenter,
        profilePresenter: widget.profilePresenter,
        pressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterView(presenter: widget.filterPresenter),
            ),
          );
        },
      ),
      ProfileView(presenter: widget.profilePresenter),
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
      body: _pages[_selectedIndex],
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
