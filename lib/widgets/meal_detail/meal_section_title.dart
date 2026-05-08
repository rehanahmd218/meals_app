import 'package:flutter/material.dart';

class MealSectionTitle extends StatelessWidget {
  const MealSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: scheme.primary,
        ),
      ),
    );
  }
}
