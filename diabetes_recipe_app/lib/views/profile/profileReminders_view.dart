//

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
          reminderInfo(
            "Remaining Meals",
            remindersViewModel.remainingMeals,
            remindersViewModel.decrementMeals,
          ),
          SizedBox(height: 16),
          reminderInfo(
            "Remaining Exercises",
            remindersViewModel.remainingExercises,
            remindersViewModel.decrementExercises,
          ),
        ],
      ),
    );
  }

  Widget reminderInfo(String label, int value, VoidCallback onDecrement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label: $value",
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: onDecrement,
        ),
      ],
    );
  }
}
