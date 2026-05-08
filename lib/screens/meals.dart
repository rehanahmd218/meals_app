import 'package:flutter/material.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/screens/meal_details.dart';
import 'package:new_meals_app/widgets/common/empty_state_view.dart';
import 'package:new_meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    this.emptyTitle = 'No meals found',
    this.emptyMessage = 'Try selecting a different category or adjusting filters.',
  });

  final String? title;
  final List<Meal> meals;
  final String emptyTitle;
  final String emptyMessage;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => MealDetails(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        meals.isNotEmpty
            ? ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return MealItem(
                  meal: meal,
                  onSelectMeal: () => _selectMeal(context, meal),
                );
              },
            )
            : EmptyStateView(
              icon: Icons.restaurant_rounded,
              title: emptyTitle,
              message: emptyMessage,
            );

    if (title == null) {
      return content;
    }

    return Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }
}
