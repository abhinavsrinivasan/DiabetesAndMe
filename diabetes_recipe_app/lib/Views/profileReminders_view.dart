import 'package:flutter/material.dart';
import '../presenters/profile_presenter.dart';

class RemindersView extends StatefulWidget {
  final ProfilePresenter presenter;

  RemindersView({required this.presenter});

  @override
  _RemindersViewState createState() => _RemindersViewState();
}

class _RemindersViewState extends State<RemindersView> {
  @override
  Widget build(BuildContext context) {
    // Get reminders (remaining meals and exercises)
    final reminders = widget.presenter.displayReminders();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Remaining Meals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remaining Meals: ${reminders['remainingMeals']}",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    widget.presenter.decrementMeals();
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),

          // Remaining Exercises
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remaining Exercises: ${reminders['remainingExercises']}",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    widget.presenter.decrementExercises();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
