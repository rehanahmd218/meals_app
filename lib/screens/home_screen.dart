import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/providers/favorites_provider.dart';
import 'package:new_meals_app/providers/filters_provider.dart';
import 'package:new_meals_app/providers/meal_search_provider.dart';
import 'package:new_meals_app/screens/meal_details.dart';
import 'package:new_meals_app/theme/app_dimens.dart';
import 'package:new_meals_app/widgets/home/home_search_field.dart';
import 'package:new_meals_app/widgets/home/meal_compact_tile.dart';
import 'package:new_meals_app/widgets/home/stats_summary_row.dart';
import 'package:new_meals_app/widgets/meal_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _openMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (ctx) => MealDetails(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(mealSearchProvider);
    final results = ref.watch(searchedMealsProvider);
    final favorites = ref.watch(favoritesProvider);
    final filteredCount = ref.watch(filteredMealsProvider).length;
    final featured =
        query.trim().isEmpty
            ? ref.watch(featuredMealsProvider)
            : results.take(8).toList();

    final scheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(AppDimens.md, AppDimens.md, AppDimens.md, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What are you cooking today?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Search recipes, browse picks, and jump into categories anytime.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppDimens.md),
                const HomeSearchField(),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppDimens.md),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                StatsSummaryTile(
                  icon: Icons.restaurant_menu_rounded,
                  value: '$filteredCount',
                  label: 'Available',
                ),
                const SizedBox(width: 12),
                StatsSummaryTile(
                  icon: Icons.star_rounded,
                  value: '${favorites.length}',
                  label: 'Favorites',
                ),
              ],
            ),
          ),
        ),
        if (featured.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    query.trim().isEmpty ? 'Featured picks' : 'Top matches',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Swipe →',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (featured.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 246,
              child: ListView.separated(
                padding: const EdgeInsets.all(AppDimens.md),
                scrollDirection: Axis.horizontal,
                itemCount: featured.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, i) {
                  final meal = featured[i];
                  return MealCompactTile(
                    meal: meal,
                    onTap: () => _openMeal(context, meal),
                  );
                },
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(AppDimens.md, 8, AppDimens.md, 12),
          sliver: SliverToBoxAdapter(
            child: Text(
              query.trim().isEmpty ? 'Browse everything' : 'Search results',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        if (results.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 48),
              child: _HomeEmptySearch(),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(bottom: AppDimens.xl),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final meal = results[index];
                return MealItem(
                  meal: meal,
                  onSelectMeal: () => _openMeal(context, meal),
                );
              }, childCount: results.length),
            ),
          ),
      ],
    );
  }
}

class _HomeEmptySearch extends StatelessWidget {
  const _HomeEmptySearch();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded, size: 48, color: scheme.outline),
        const SizedBox(height: 12),
        Text(
          'No matches',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Try another keyword or relax filters from the drawer.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
