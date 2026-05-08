import 'package:flutter/material.dart';

class MealIngredientTile extends StatelessWidget {
  const MealIngredientTile({super.key, required this.line});

  final String line;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8, color: scheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              line,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.35,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
