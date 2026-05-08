import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';

class FavoritesNotifier extends Notifier<List<Meal>> {
  @override
  List<Meal> build() => [];

  bool isFavorite(Meal meal) => state.any((m) => m.id == meal.id);

  bool toggleFavorite(Meal meal) {
    if (isFavorite(meal)) {
      state = [...state.where((m) => m.id != meal.id)];
      return false;
    }
    state = [...state, meal];
    return true;
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<Meal>>(
  FavoritesNotifier.new,
);
