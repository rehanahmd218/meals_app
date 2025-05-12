import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veganFree: false,
  Filter.vegetarian: false,
};

class _TabsScreenState extends State<TabsScreen> {
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  List<Meal> availableMeals = dummyMeals;
  final List<Meal> favouriteMeals = [];
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen() async {
    Navigator.of(context).pop();
    final result = await Navigator.of(context).push<Map<Filter, bool>>(
      MaterialPageRoute(
        builder: (context) {
          return FilterScreen(currentFilters: _selectedFilters);
        },
      ),
    );
    setState(() {
      print('Result: $result');
      _selectedFilters = result ?? kInitialFilters;
    });
  }

  void _onToggleFavourites(Meal meal) {
    String snackBarMessage = 'Meal added to favourites';
    if (favouriteMeals.contains(meal)) {
      setState(() {
        favouriteMeals.remove(meal);
      });
      snackBarMessage = 'Meal removed from favourites';
    } else {
      setState(() {
        favouriteMeals.add(meal);
      });
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(snackBarMessage), duration: Duration(seconds: 3)),
    );
  }

  int _selectedPageIndex = 0;
  String activeTitle = 'Categories';
  Widget? activePage;

  @override
  Widget build(BuildContext context) {
    availableMeals =
        dummyMeals.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.veganFree]! && !meal.isVegan) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
    print('Length of Available Meals: ${availableMeals.length}');
    if (_selectedPageIndex == 1) {
      activeTitle = 'Your Favourites';
      activePage = MealsScreen(
        meals: favouriteMeals,
        onToggleFavourites: _onToggleFavourites,
      );
    } else {
      activeTitle = 'Categories';
      activePage = CategoriesScreen(
        onToggleFavourites: _onToggleFavourites,
        availableMeals: availableMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(activeTitle)),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
