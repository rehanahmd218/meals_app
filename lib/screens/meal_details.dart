import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_detail_extra.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onToggleFavourites;
  const MealDetails({
    super.key,
    required this.meal,
    required this.onToggleFavourites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavourites(meal);
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: MealDetailExtra(meal: meal),
    );
  }
}
