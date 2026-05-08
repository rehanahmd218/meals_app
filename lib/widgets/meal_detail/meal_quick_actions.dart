import 'package:flutter/material.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/widgets/meal_detail/cooking_timer_sheet.dart';

class MealQuickActions extends StatelessWidget {
  const MealQuickActions({
    super.key,
    required this.meal,
    required this.onAddToShoppingList,
  });

  final Meal meal;
  final VoidCallback onAddToShoppingList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        FilledButton.tonalIcon(
          onPressed: () => CookingTimerSheet.show(context, meal),
          icon: const Icon(Icons.timer_outlined),
          label: const Text('Kitchen timer'),
        ),
        OutlinedButton.icon(
          onPressed: onAddToShoppingList,
          icon: const Icon(Icons.playlist_add_rounded),
          label: const Text('Add to grocery list'),
        ),
      ],
    );
  }
}
