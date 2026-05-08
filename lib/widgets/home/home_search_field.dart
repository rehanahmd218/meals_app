import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_meals_app/providers/meal_search_provider.dart';

class HomeSearchField extends ConsumerStatefulWidget {
  const HomeSearchField({super.key});

  @override
  ConsumerState<HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends ConsumerState<HomeSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(mealSearchProvider));
    _controller.addListener(_pushToProvider);
  }

  void _pushToProvider() {
    ref.read(mealSearchProvider.notifier).setQuery(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(_pushToProvider);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mealSearchProvider, (previous, next) {
      if (_controller.text != next) {
        _controller.value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
    });

    final query = ref.watch(mealSearchProvider);

    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search meals or ingredients…',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon:
            query.isEmpty
                ? null
                : IconButton(
                  tooltip: 'Clear',
                  onPressed: () {
                    ref.read(mealSearchProvider.notifier).clear();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
      ),
    );
  }
}
