import 'package:flutter/material.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/models/meal_extensions.dart';

class MealDietChips extends StatelessWidget {
  const MealDietChips({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final badges = meal.dietBadges;
    if (badges.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final label in badges)
          Chip(
            label: Text(label),
            visualDensity: VisualDensity.compact,
            backgroundColor: scheme.secondaryContainer,
            labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: scheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
      ],
    );
  }
}
