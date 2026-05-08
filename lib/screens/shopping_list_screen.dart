import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/providers/favorites_provider.dart';
import 'package:new_meals_app/providers/shopping_list_provider.dart';
import 'package:new_meals_app/widgets/common/empty_state_view.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(shoppingListProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery list'),
        actions: [
          IconButton(
            tooltip: 'Merge ingredients from favorites',
            onPressed:
                favorites.isEmpty
                    ? null
                    : () {
                      ref
                          .read(shoppingListProvider.notifier)
                          .addFromFavorites(favorites);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added ingredients from ${favorites.length} saved recipes.',
                          ),
                        ),
                      );
                    },
            icon: const Icon(Icons.star_rounded),
          ),
          if (items.isNotEmpty)
            IconButton(
              tooltip: 'Clear list',
              onPressed: () => ref.read(shoppingListProvider.notifier).clear(),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      body:
          items.isEmpty
              ? EmptyStateView(
                icon: Icons.shopping_basket_outlined,
                title: 'Your list is empty',
                message:
                    'Open a recipe and tap “Add to grocery list”, or merge favorites from the toolbar.',
              )
              : ListView.builder(
                padding: const EdgeInsets.only(bottom: 24),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final line = items[index];
                  return ListTile(
                    leading: Icon(
                      Icons.circle_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(line),
                    trailing: IconButton(
                      tooltip: 'Remove',
                      icon: const Icon(Icons.close_rounded),
                      onPressed:
                          () => ref
                              .read(shoppingListProvider.notifier)
                              .removeAt(index),
                    ),
                  );
                },
              ),
    );
  }
}
