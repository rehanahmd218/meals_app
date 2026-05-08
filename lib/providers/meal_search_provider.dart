import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/providers/filters_provider.dart';

class MealSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) {
    state = value;
  }

  void clear() => state = '';
}

final mealSearchProvider =
    NotifierProvider<MealSearchNotifier, String>(MealSearchNotifier.new);

final searchedMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(filteredMealsProvider);
  final q = ref.watch(mealSearchProvider).trim().toLowerCase();
  if (q.isEmpty) return meals;
  return meals
      .where(
        (m) =>
            m.title.toLowerCase().contains(q) ||
            m.ingredients.any((i) => i.toLowerCase().contains(q)),
      )
      .toList();
});

final featuredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(filteredMealsProvider);
  return meals.take(8).toList();
});
