import 'package:flutter/material.dart';
import '../presenters/filter_presenter.dart';
import 'filter_view.dart';

class HomeView extends StatelessWidget {
  final FilterPresenter presenter;

  HomeView({required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diabetes and Me"),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add notification functionality if needed
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterView(presenter: presenter), // Pass FilterPresenter
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome to the Home Page!"),
      ),
    );
  }
}
