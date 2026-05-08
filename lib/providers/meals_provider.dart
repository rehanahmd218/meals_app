import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/data/dummy_meals.dart';
import 'package:new_meals_app/models/meal.dart';

final mealsProvider = Provider<List<Meal>>((ref) => dummyMeals);
