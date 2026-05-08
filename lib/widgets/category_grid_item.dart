import 'package:flutter/material.dart';

import 'package:new_meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final VoidCallback onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelectCategory,
        splashColor: scheme.primary.withValues(alpha: 0.18),
        highlightColor: scheme.primary.withValues(alpha: 0.08),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: category.color.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _CategoryBackdrop(
                imageUrl: category.imageUrl,
                categoryColor: category.color,
                scheme: scheme,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.12),
                      category.color.withValues(alpha: 0.82),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      shadows: const [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 14,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryBackdrop extends StatelessWidget {
  const _CategoryBackdrop({
    required this.imageUrl,
    required this.categoryColor,
    required this.scheme,
  });

  final String imageUrl;
  final Color categoryColor;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ColoredBox(color: categoryColor);
        },
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return ColoredBox(
          color: categoryColor.withValues(alpha: 0.35),
          child: Center(
            child: SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: scheme.onPrimary,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return ColoredBox(color: categoryColor);
      },
    );
  }
}
