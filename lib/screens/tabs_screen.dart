import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/providers/favorites_provider.dart';
import 'package:new_meals_app/providers/filters_provider.dart';
import 'package:new_meals_app/screens/categories.dart';
import 'package:new_meals_app/screens/filters.dart';
import 'package:new_meals_app/screens/home_screen.dart';
import 'package:new_meals_app/screens/meals.dart';
import 'package:new_meals_app/screens/shopping_list_screen.dart';
import 'package:new_meals_app/screens/weekly_planner_screen.dart';
import 'package:new_meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  Future<void> _openFilters() async {
    Navigator.of(context).pop();
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (context) => const FilterScreen()),
    );
  }

  void _openShoppingList() {
    Navigator.of(context).pop();
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => const ShoppingListScreen(),
      ),
    );
  }

  void _openWeeklyPlanner() {
    Navigator.of(context).pop();
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => const WeeklyPlannerScreen(),
      ),
    );
  }

  void _selectTab(int index) {
    Navigator.of(context).pop();
    setState(() => _selectedPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    final favoriteMeals = ref.watch(favoritesProvider);

    late final String title;
    late final Widget page;

    switch (_selectedPageIndex) {
      case 0:
        title = 'Kitchen';
        page = const HomeScreen();
        break;
      case 1:
        title = 'Categories';
        page = CategoriesScreen(availableMeals: availableMeals);
        break;
      case 2:
        title = 'Favorites';
        page = MealsScreen(
          meals: favoriteMeals,
          emptyTitle: 'No favorites yet',
          emptyMessage:
              'Tap the star on any recipe to save it here for quick access.',
        );
        break;
      default:
        title = 'Kitchen';
        page = const HomeScreen();
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: MainDrawer(
        currentTabIndex: _selectedPageIndex,
        onSelectTab: _selectTab,
        onOpenFilters: _openFilters,
        onOpenShoppingList: _openShoppingList,
        onOpenWeeklyPlanner: _openWeeklyPlanner,
      ),
      body: page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedPageIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedPageIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_rounded),
            selectedIcon: Icon(Icons.star_rounded),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
