import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavourites,
    required this.availableMeals,
  });
  final void Function(Meal meal) onToggleFavourites;
  final List<Meal> availableMeals;

  void _selectCategoy(BuildContext context, Category category) {
    final filterdMeals =
        availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            title: category.title,
            meals: filterdMeals,
            onToggleFavourites: onToggleFavourites,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('Length of Available Meals: ${availableMeals.length}');
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (Category category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategoy(context, category);
            },
          ),
      ],
    );
  }
}
