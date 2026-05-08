import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/providers/favorites_provider.dart';
import 'package:new_meals_app/providers/shopping_list_provider.dart';
import 'package:new_meals_app/widgets/meal_detail/meal_detail_body.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((m) => m.id == meal.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Remove from favorites' : 'Save recipe',
            onPressed: () {
              final added =
                  ref.read(favoritesProvider.notifier).toggleFavorite(meal);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    added ? 'Saved to favorites' : 'Removed from favorites',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.85, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                key: ValueKey<bool>(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: MealDetailBody(
          meal: meal,
          onAddToShoppingList: () {
            ref.read(shoppingListProvider.notifier).addFromMeal(meal);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ingredients added to grocery list'),
              ),
            );
          },
        ),
      ),
    );
  }
}
