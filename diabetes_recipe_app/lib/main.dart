import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'models/recipe_model.dart';
import 'viewmodels/profile/profile_viewmodel.dart';
import 'viewmodels/profile/profileReminders_viewmodel.dart';
import 'viewmodels/filter/filter_viewmodel.dart';
import 'views/home/homescreenRecipes_view.dart';
import 'views/profile/profileHealth_view.dart';
import 'views/filter/filter_view.dart';
import 'views/profile/profile_view.dart';
import 'views/social/socialMedia_view.dart';
import 'viewmodels/profile/profileHealth_viewmodel.dart';
import 'viewmodels/profile/profileFavorites_viewmodel.dart';
import 'viewmodels/home/homescreenRecipes_viewmodel.dart';
import 'viewmodels/social/socialMedia_viewmodel.dart';

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
      ingredients: ["Pasta", "Feta Cheese", "Tomatoes"],
      preparationSteps: [
        "Step 1: Boil pasta.",
        "Step 2: Add feta and tomatoes.",
        "Step 3: Bake for 20 minutes."
      ],
      imagePath: "assets/images/fetaPasta.jpg",
      carbRange: 20,
      sugarRange: 2,
    ),
    Recipe(
      title: "Chicken Salad",
      cuisine: "American",
      cookTime: 15,
      ingredients: ["Chicken", "Lettuce", "Dressing"],
      preparationSteps: [
        "Step 1: Grill chicken.",
        "Step 2: Toss lettuce with dressing.",
        "Step 3: Combine chicken with lettuce."
      ],
      imagePath: "assets/images/ChickenSalad.jpg",
      carbRange: 10,
      sugarRange: 3,
    ),
    Recipe(
      title: "Avocado Toast",
      cuisine: "Mexican",
      cookTime: 10,
      ingredients: ["Avocado", "Bread", "Salt"],
      preparationSteps: [
        "Step 1: Toast bread.",
        "Step 2: Mash avocado and spread on bread.",
        "Step 3: Sprinkle with salt."
      ],
      imagePath: "assets/images/AvocadoToast.jpg",
      carbRange: 30,
      sugarRange: 6,
    ),
    Recipe(
      title: "Vegetable Stir Fry",
      cuisine: "Asian",
      cookTime: 20,
      ingredients: ["Broccoli", "Carrots", "Soy Sauce", "Garlic"],
      preparationSteps: [
        "Step 1: Heat oil in a pan.",
        "Step 2: Add vegetables and stir-fry for 5 minutes.",
        "Step 3: Add soy sauce and cook for another 5 minutes."
      ],
      imagePath: "assets/images/VegetableStirFry.jpg",
      carbRange: 15,
      sugarRange: 6,
    ),
    Recipe(
      title: "Berry Smoothie",
      cuisine: "American",
      cookTime: 5,
      ingredients: ["Berries", "Yogurt", "Honey"],
      preparationSteps: [
        "Step 1: Combine all ingredients in a blender.",
        "Step 2: Blend until smooth.",
        "Step 3: Serve chilled."
      ],
      imagePath: "assets/images/BerrySmoothie.jpg",
      carbRange: 18,
      sugarRange: 8,
    ),
    Recipe(
      title: "Grilled Salmon",
      cuisine: "Mediterranean",
      cookTime: 30,
      ingredients: ["Salmon", "Olive Oil", "Garlic", "Lemon"],
      preparationSteps: [
        "Step 1: Marinate salmon with olive oil, garlic, and lemon.",
        "Step 2: Preheat grill to medium heat.",
        "Step 3: Grill salmon for 10-15 minutes per side."
      ],
      imagePath: "assets/images/GrilledSalmon.jpg",
      carbRange: 5,
      sugarRange: 13,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileRemindersViewModel(userModel: userModel),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileHealthViewModel(userModel: userModel),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileFavoritesViewModel(userModel: userModel),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeScreenRecipesViewModel(
            recipeList: recipeList,
            userModel: userModel,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FilterViewModel(recipeList),
        ),
        ChangeNotifierProvider(
          create: (_) => SocialMediaViewModel(
            recipes: [
              {
                "title": "Feta Pasta",
                "imagePath": "assets/images/FetaPasta.jpg",
                "likes": 34,
                "liked": false,
                "comments": ["Looks delicious!", "I tried this, and it's amazing!"],
              },
              {
                "title": "Chicken Salad",
                "imagePath": "assets/images/ChickenSalad.jpg",
                "likes": 12,
                "liked": false,
                "comments": ["Healthy and tasty!", "Perfect for a quick lunch."],
              },
              {
                "title": "Avocado Toast",
                "imagePath": "assets/images/AvocadoToast.jpg",
                "likes": 45,
                "liked": false,
                "comments": ["Simple yet satisfying!", "My go-to breakfast."],
              },
            ],
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Diabetes Recipe App',
        home: MainPage(
          profilePresenter: ProfilePresenter(userModel),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final ProfilePresenter profilePresenter;

  MainPage({required this.profilePresenter});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int tabNum = 1;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Consumer<SocialMediaViewModel>(
        builder: (context, viewModel, child) => SocialMediaView(),
      ),
      Consumer<FilterViewModel>(
        builder: (context, filterViewModel, child) {
          return HomeScreenRecipesView(
            filterViewModel: filterViewModel,
            profilePresenter: widget.profilePresenter,
            pressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterView(),
                ),
              );
            },
          );
        },
      ),
      ProfileView(
        presenter: widget.profilePresenter,
      ),
    ];
  }

  void Tapped(int index) {
    setState(() {
      tabNum = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[tabNum],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabNum,
        items: const [
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
        onTap: Tapped,
      ),
    );
  }
}
