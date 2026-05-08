import 'package:new_meals_app/models/meal.dart';

extension MealDietLabels on Meal {
  List<String> get dietBadges => [
    if (isGlutenFree) 'Gluten-free',
    if (isLactoseFree) 'Lactose-free',
    if (isVegan) 'Vegan',
    if (isVegetarian) 'Vegetarian',
  ];
}
