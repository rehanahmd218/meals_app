import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyPlanNotifier extends Notifier<Map<int, String?>> {
  static const _weekdays = [1, 2, 3, 4, 5, 6, 7];

  @override
  Map<int, String?> build() => {for (final d in _weekdays) d: null};

  void setMealForDay(int weekday, String? mealId) {
    state = {...state, weekday: mealId};
  }

  void clearWeek() {
    state = {for (final d in _weekdays) d: null};
  }
}

final weeklyPlanProvider =
    NotifierProvider<WeeklyPlanNotifier, Map<int, String?>>(
      WeeklyPlanNotifier.new,
    );
