import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

enum Filter { glutenFree, lactoseFree, veganFree, vegetarian }

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _veganFree = false;
  bool _vegetarian = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters[Filter.glutenFree] ?? false;
    _lactoseFree = widget.currentFilters[Filter.lactoseFree] ?? false;
    _veganFree = widget.currentFilters[Filter.veganFree] ?? false;
    _vegetarian = widget.currentFilters[Filter.vegetarian] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          // Route didn't pop yet; we manually pop with result
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFree,
            Filter.lactoseFree: _lactoseFree,
            Filter.veganFree: _veganFree,
            Filter.vegetarian: _vegetarian,
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Filters')),
        body: Column(
          children: [
            SwitchListTile(
              value: _glutenFree,
              onChanged: (boolValue) {
                setState(() {
                  _glutenFree = boolValue;
                });
              },
              title: const Text('Gluten Free'),
              subtitle: const Text('Only include gluten free meals'),
            ),
            SwitchListTile(
              value: _lactoseFree,
              onChanged: (boolValue) {
                setState(() {
                  _lactoseFree = boolValue;
                });
              },
              title: const Text('Lactose Free'),
              subtitle: const Text('Only include Lactose free meals'),
            ),
            SwitchListTile(
              value: _veganFree,
              onChanged: (boolValue) {
                setState(() {
                  _veganFree = boolValue;
                });
              },
              title: const Text('Vegan Free Food'),
              subtitle: const Text('Only include Vegan Free Meals'),
            ),
            SwitchListTile(
              value: _vegetarian,
              onChanged: (boolValue) {
                setState(() {
                  _vegetarian = boolValue;
                });
              },
              title: const Text('Vegetarian Food'),
              subtitle: const Text('Only include Vegatarian meals'),
            ),
          ],
        ),
      ),
    );
  }
}
