import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/providers/theme_mode_provider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
    required this.currentTabIndex,
    required this.onSelectTab,
    required this.onOpenFilters,
    required this.onOpenShoppingList,
    required this.onOpenWeeklyPlanner,
  });

  final int currentTabIndex;
  final ValueChanged<int> onSelectTab;
  final VoidCallback onOpenFilters;
  final VoidCallback onOpenShoppingList;
  final VoidCallback onOpenWeeklyPlanner;

  String _themeSubtitle(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'Following system',
      ThemeMode.light => 'Light palette',
      ThemeMode.dark => 'Dark palette',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeMode = ref.watch(themeModeProvider);

    final headerFg = scheme.onPrimaryContainer;

    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.78,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    scheme.primaryContainer,
                    scheme.secondaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.restaurant_menu_rounded,
                      size: 34,
                      color: headerFg,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Nosh',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: headerFg,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Recipes, timers & groceries in one place.',
                      style: textTheme.bodySmall?.copyWith(
                        color: headerFg.withValues(alpha: 0.88),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home_rounded),
                    title: const Text('Kitchen home'),
                    selected: currentTabIndex == 0,
                    onTap: () => onSelectTab(0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.grid_view_rounded),
                    title: const Text('Browse categories'),
                    selected: currentTabIndex == 1,
                    onTap: () => onSelectTab(1),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star_rounded),
                    title: const Text('Saved favorites'),
                    selected: currentTabIndex == 2,
                    onTap: () => onSelectTab(2),
                  ),
                  const Divider(height: 32),
                  ListTile(
                    leading: const Icon(Icons.tune_rounded),
                    title: const Text('Diet filters'),
                    subtitle: const Text('Gluten-free, vegan & more'),
                    onTap: onOpenFilters,
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_basket_rounded),
                    title: const Text('Grocery list'),
                    subtitle: const Text('Ingredients you plan to buy'),
                    onTap: onOpenShoppingList,
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_month_rounded),
                    title: const Text('Weekly meal planner'),
                    subtitle: const Text('Plan dinners for the week'),
                    onTap: onOpenWeeklyPlanner,
                  ),
                  const Divider(height: 32),
                  ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Appearance'),
                    subtitle: Text(_themeSubtitle(themeMode)),
                    trailing: IconButton(
                      tooltip: 'Cycle light · dark · system',
                      onPressed: () =>
                          ref.read(themeModeProvider.notifier).cycle(),
                      icon: const Icon(Icons.brightness_6_rounded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 16),
                    child: SegmentedButton<ThemeMode>(
                      style: SegmentedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        textStyle: textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 8,
                        ),
                      ),
                      segments: [
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.system,
                          icon: const Icon(Icons.brightness_auto_rounded, size: 18),
                          label: Text(
                            'Auto',
                            style: textTheme.labelSmall?.copyWith(fontSize: 11),
                          ),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.light,
                          icon: const Icon(Icons.light_mode_rounded, size: 18),
                          label: Text(
                            'Light',
                            style: textTheme.labelSmall?.copyWith(fontSize: 11),
                          ),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.dark,
                          icon: const Icon(Icons.dark_mode_rounded, size: 18),
                          label: Text(
                            'Dark',
                            style: textTheme.labelSmall?.copyWith(fontSize: 11),
                          ),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (selection) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setMode(selection.first);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
