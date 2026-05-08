import 'package:flutter/material.dart';
import 'package:new_meals_app/models/category.dart';
import 'package:new_meals_app/screens/meals.dart';
import 'package:new_meals_app/widgets/category_grid_item.dart';
import 'package:new_meals_app/data/dummy_data.dart';
import 'package:new_meals_app/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategoy(BuildContext context, Category category) {
    final filterdMeals =
        widget.availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(title: category.title, meals: filterdMeals);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: GridView(
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
      ),
    );
  }
}
