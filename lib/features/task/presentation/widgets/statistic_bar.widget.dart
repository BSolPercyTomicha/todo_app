import 'package:flutter/material.dart';

class StatisticsBar extends StatelessWidget {
  final String label;
  final int value;
  final int total;
  final int percentage;
  final Color color;

  const StatisticsBar({
    super.key,
    required this.label,
    required this.value,
    required this.total,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double heightFactor = value == 0 ? 0 : value / total;
    final text = value == 0 ? '' : '$percentage%';

    return SizedBox(
      height: 200,
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              child: FractionallySizedBox(
                heightFactor: heightFactor,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 60,
                  color: color,
                  child: Center(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$label: $value',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
