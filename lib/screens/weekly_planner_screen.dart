import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/models/meal.dart';
import 'package:new_meals_app/providers/meals_provider.dart';
import 'package:new_meals_app/providers/weekly_plan_provider.dart';

class WeeklyPlannerScreen extends ConsumerWidget {
  const WeeklyPlannerScreen({super.key});

  static const _orderedWeekdays = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  ];

  static String _weekdayLabel(int weekday) {
    return switch (weekday) {
      DateTime.monday => 'Monday',
      DateTime.tuesday => 'Tuesday',
      DateTime.wednesday => 'Wednesday',
      DateTime.thursday => 'Thursday',
      DateTime.friday => 'Friday',
      DateTime.saturday => 'Saturday',
      DateTime.sunday => 'Sunday',
      _ => 'Day',
    };
  }

  Future<void> _pickMeal(
    BuildContext context,
    WidgetRef ref,
    int weekday,
    List<Meal> meals,
  ) async {
    final sorted = [...meals]..sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );

    final selectedId = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        final height = MediaQuery.sizeOf(ctx).height * 0.58;
        return SafeArea(
          child: SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                  child: Text(
                    'Choose a meal · ${_weekdayLabel(weekday)}',
                    style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sorted.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ListTile(
                          leading: const Icon(Icons.block_rounded),
                          title: const Text('No meal planned'),
                          onTap: () => Navigator.of(context).pop(''),
                        );
                      }
                      final meal = sorted[index - 1];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(meal.imageUrl),
                          onBackgroundImageError: (_, _) {},
                        ),
                        title: Text(meal.title),
                        subtitle: Text('${meal.duration} min'),
                        onTap: () => Navigator.of(context).pop(meal.id),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!context.mounted) return;
    if (selectedId == null) return;
    ref.read(weeklyPlanProvider.notifier).setMealForDay(
      weekday,
      selectedId.isEmpty ? null : selectedId,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(weeklyPlanProvider);
    final meals = ref.watch(mealsProvider);
    final byId = {for (final m in meals) m.id: m};
    final hasAny = plan.values.any((id) => id != null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly meal planner'),
        actions: [
          if (hasAny)
            TextButton(
              onPressed: () =>
                  ref.read(weeklyPlanProvider.notifier).clearWeek(),
              child: const Text('Clear week'),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            'Assign one recipe to each day. Open the sheet to pick from your full recipe list.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.72),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          for (final weekday in _orderedWeekdays)
            _DayPlanCard(
              label: _weekdayLabel(weekday),
              meal: plan[weekday] != null ? byId[plan[weekday]] : null,
              onTap: () => _pickMeal(context, ref, weekday, meals),
              onClear:
                  plan[weekday] != null
                      ? () => ref
                          .read(weeklyPlanProvider.notifier)
                          .setMealForDay(weekday, null)
                      : null,
            ),
        ],
      ),
    );
  }
}

class _DayPlanCard extends StatelessWidget {
  const _DayPlanCard({
    required this.label,
    required this.meal,
    required this.onTap,
    required this.onClear,
  });

  final String label;
  final Meal? meal;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                foregroundColor: scheme.onPrimaryContainer,
                child: Text(
                  label.isNotEmpty ? label[0] : '?',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meal?.title ?? 'Tap to choose a meal',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            meal != null
                                ? scheme.onSurface
                                : scheme.onSurface.withValues(alpha: 0.55),
                        fontWeight:
                            meal != null ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (meal != null && onClear != null)
                IconButton(
                  tooltip: 'Remove',
                  onPressed: onClear,
                  icon: const Icon(Icons.close_rounded),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: scheme.onSurface.withValues(alpha: 0.45),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
