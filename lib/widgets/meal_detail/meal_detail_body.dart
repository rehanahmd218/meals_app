import 'package:flutter/material.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/theme/app_dimens.dart';
import 'package:new_meals_app/widgets/meal_detail/meal_diet_chips.dart';
import 'package:new_meals_app/widgets/meal_detail/meal_ingredient_tile.dart';
import 'package:new_meals_app/widgets/meal_detail/meal_quick_actions.dart';
import 'package:new_meals_app/widgets/meal_detail/meal_section_title.dart';
import 'package:new_meals_app/widgets/meal_detail/meal_step_tile.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailBody extends StatelessWidget {
  const MealDetailBody({
    super.key,
    required this.meal,
    required this.onAddToShoppingList,
  });

  final Meal meal;
  final VoidCallback onAddToShoppingList;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.md,
        AppDimens.sm,
        AppDimens.md,
        AppDimens.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            child: Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: AppDimens.heroHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.md),
          MealDietChips(meal: meal),
          const SizedBox(height: AppDimens.sm),
          MealQuickActions(
            meal: meal,
            onAddToShoppingList: onAddToShoppingList,
          ),
          const SizedBox(height: AppDimens.md),
          MealSectionTitle(title: 'Ingredients'),
          ...meal.ingredients.map((line) => MealIngredientTile(line: line)),
          const SizedBox(height: AppDimens.sm),
          MealSectionTitle(title: 'Steps'),
          ...List.generate(
            meal.steps.length,
            (i) => MealStepTile(index: i, text: meal.steps[i]),
          ),
          const SizedBox(height: AppDimens.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.md),
              child: Row(
                children: [
                  Icon(Icons.tips_and_updates_outlined, color: scheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tip: prep mise en place before starting the timer so everything is within reach.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
