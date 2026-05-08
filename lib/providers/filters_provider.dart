import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FiltersNotifier extends Notifier<Map<Filter, bool>> {
  @override
  Map<Filter, bool> build() => {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

  void setFilters(Map<Filter, bool> filters) {
    state = Map<Filter, bool>.from(filters);
  }

  void setFilter(Filter filter, bool value) {
    state = {...state, filter: value};
  }
}

final filtersProvider =
    NotifierProvider<FiltersNotifier, Map<Filter, bool>>(FiltersNotifier.new);

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final activeFilters = ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
