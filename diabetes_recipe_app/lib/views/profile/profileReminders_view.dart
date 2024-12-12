import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile/profileReminders_viewmodel.dart';

class RemindersView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final remindersViewModel = Provider.of<ProfileRemindersViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remaining Meals: ${remindersViewModel.remainingMeals}",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  remindersViewModel.decrementMeals();
                },
              ),
            ],
          ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remaining Exercises: ${remindersViewModel.remainingExercises}",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  remindersViewModel.decrementExercises();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
