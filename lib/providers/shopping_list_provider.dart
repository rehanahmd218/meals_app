import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';

class ShoppingListNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addFromMeal(Meal meal) {
    final next = [...state];
    for (final ingredient in meal.ingredients) {
      if (!next.contains(ingredient)) next.add(ingredient);
    }
    state = next;
  }

  void addFromFavorites(List<Meal> favorites) {
    final next = [...state];
    for (final meal in favorites) {
      for (final ingredient in meal.ingredients) {
        if (!next.contains(ingredient)) next.add(ingredient);
      }
    }
    state = next;
  }

  void removeAt(int index) {
    state = [...state]..removeAt(index);
  }

  void clear() => state = [];
}

final shoppingListProvider =
    NotifierProvider<ShoppingListNotifier, List<String>>(ShoppingListNotifier.new);
