import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailExtra extends StatelessWidget {
  final Meal meal;
  const MealDetailExtra({super.key, required this.meal});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Image.network(
            meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          for (String ingredient in meal.ingredients)
            Text(
              ingredient,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 10),
          Text(
            'Steps',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          for (String step in meal.steps)
            Text(
              step,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
