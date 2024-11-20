//


//child
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
    
    //
    final reminders = widget.presenter.displayReminders();

    //padding along edge
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [

          //remaining meals
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

          //exercise decrement
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
