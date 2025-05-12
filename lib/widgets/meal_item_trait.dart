import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  final String label;
  final IconData icon;
  const MealItemTrait({super.key, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
