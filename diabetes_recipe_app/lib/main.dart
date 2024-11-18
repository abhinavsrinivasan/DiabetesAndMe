import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'presenters/profile_presenter.dart';
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

  @override
  Widget build(BuildContext context) {
    final presenter = ProfilePresenter(userModel);

    return MaterialApp(
      title: 'Diabetes Recipe App',
      home: MainPage(presenter: presenter),
    );
  }
}

class MainPage extends StatefulWidget {
  final ProfilePresenter presenter;

  MainPage({required this.presenter});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2; // Default to Profile tab

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Center(child: Text("Home View Placeholder")), // Replace with actual HomeView
      Center(child: Text("Search View Placeholder")), // Replace with SearchView
      ProfileView(presenter: widget.presenter), // Profile page
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
