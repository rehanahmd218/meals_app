import 'dart:async';

import 'package:flutter/material.dart';

import 'package:new_meals_app/models/meal.dart';

class CookingTimerSheet extends StatefulWidget {
  const CookingTimerSheet({super.key, required this.meal});

  final Meal meal;

  static Future<void> show(BuildContext context, Meal meal) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => CookingTimerSheet(meal: meal),
    );
  }

  @override
  State<CookingTimerSheet> createState() => _CookingTimerSheetState();
}

class _CookingTimerSheetState extends State<CookingTimerSheet> {
  late Duration _remaining;
  Timer? _timer;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _remaining = Duration(minutes: widget.meal.duration);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick(Timer t) {
    if (!mounted) return;
    if (_remaining.inSeconds <= 1) {
      _timer?.cancel();
      setState(() {
        _remaining = Duration.zero;
        _running = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Timer finished — check your dish!')),
      );
      return;
    }
    setState(() {
      _remaining -= const Duration(seconds: 1);
    });
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  String get _label {
    final h = _remaining.inHours;
    final m = _remaining.inMinutes.remainder(60);
    final s = _remaining.inSeconds.remainder(60);
    if (h > 0) return '$h:${_two(m)}:${_two(s)}';
    return '${_two(m)}:${_two(s)}';
  }

  void _toggle() {
    if (_remaining.inSeconds == 0) {
      _remaining = Duration(minutes: widget.meal.duration);
    }
    setState(() {
      _running = !_running;
      if (_running) {
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 1), _tick);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: MediaQuery.paddingOf(context).bottom + 24,
        top: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.meal.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Preset matches total recipe time (${widget.meal.duration} min). Pause anytime.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            _label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _toggle,
            icon: Icon(_running ? Icons.pause_rounded : Icons.play_arrow_rounded),
            label: Text(_running ? 'Pause' : 'Start'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              _timer?.cancel();
              setState(() {
                _running = false;
                _remaining = Duration(minutes: widget.meal.duration);
              });
            },
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
