// reminders_view.dart

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
  @override
Widget build(BuildContext context) {
  final reminders = widget.presenter.displayReminders();

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        _buildReminderRow(
          "Remaining Meals",
          reminders['remainingMeals']!,
          widget.presenter.decrementMeals,
        ),
        SizedBox(height: 16),
        _buildReminderRow(
          "Remaining Exercises",
          reminders['remainingExercises']!,
          widget.presenter.decrementExercises,
        ),
      ],
    ),
  );
}


  Widget _buildReminderRow(String label, int value, VoidCallback onDecrement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label: $value",
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              onDecrement();
            });
          },
        ),
      ],
    );
  }
}
