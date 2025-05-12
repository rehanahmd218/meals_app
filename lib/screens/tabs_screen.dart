import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> favouriteMeals = [];
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
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
    if (_selectedPageIndex == 1) {
      activeTitle = 'Your Favourites';
      activePage = MealsScreen(
        meals: favouriteMeals,
        onToggleFavourites: _onToggleFavourites,
      );
    } else {
      activeTitle = 'Categories';
      activePage = CategoriesScreen(onToggleFavourites: _onToggleFavourites);
    }
    return Scaffold(
      appBar: AppBar(title: Text(activeTitle)),
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
