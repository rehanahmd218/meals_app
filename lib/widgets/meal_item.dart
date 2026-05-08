import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/theme/app_dimens.dart';
import 'package:new_meals_app/utils/text_formatting.dart';
import 'package:new_meals_app/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final VoidCallback onSelectMeal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.md, vertical: 8),
      child: Material(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onSelectMeal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: meal.id,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(meal.imageUrl),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.78),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 28, 14, 14),
                        child: Column(
                          children: [
                            Text(
                              meal.title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MealItemTrait(
                                  label: '${meal.duration} min',
                                  icon: Icons.schedule_rounded,
                                ),
                                const SizedBox(width: 12),
                                MealItemTrait(
                                  label: toTitleCase(meal.complexity.name),
                                  icon: Icons.trending_flat_rounded,
                                ),
                                const SizedBox(width: 12),
                                MealItemTrait(
                                  label: toTitleCase(meal.affordability.name),
                                  icon: Icons.payments_outlined,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
