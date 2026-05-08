import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/providers/filters_provider.dart';
import 'package:new_meals_app/widgets/filters/filter_switch_tile.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Diet filters')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        children: [
          Text(
            'Only show recipes that match these preferences.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          FilterSwitchTile(
            value: activeFilters[Filter.glutenFree]!,
            title: 'Gluten-free',
            subtitle: 'Hide recipes that contain gluten',
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, value);
            },
          ),
          FilterSwitchTile(
            value: activeFilters[Filter.lactoseFree]!,
            title: 'Lactose-free',
            subtitle: 'Hide recipes with lactose',
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, value);
            },
          ),
          FilterSwitchTile(
            value: activeFilters[Filter.vegan]!,
            title: 'Vegan',
            subtitle: 'Only fully plant-based dishes',
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, value);
            },
          ),
          FilterSwitchTile(
            value: activeFilters[Filter.vegetarian]!,
            title: 'Vegetarian',
            subtitle: 'No meat or fish',
            onChanged: (value) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, value);
            },
          ),
        ],
      ),
    );
  }
}
