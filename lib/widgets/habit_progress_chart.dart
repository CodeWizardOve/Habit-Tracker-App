import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/habit.dart';
import '../models/habit_completion.dart';

class HabitProgressChart extends StatelessWidget {
  final List<HabitCompletion> completions;
  final HabitFrequency frequency;

  const HabitProgressChart({
    super.key,
    required this.completions,
    required this.frequency,
  });

  List<BarChartGroupData> _getBarGroups() {
    final now = DateTime.now();
    final List<BarChartGroupData> groups = [];

    if (frequency == HabitFrequency.daily) {
      // Show last 7 days
      for (var i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        final completed = completions.any((c) => 
          c.date.year == date.year && 
          c.date.month == date.month && 
          c.date.day == date.day &&
          c.completed
        );

        groups.add(BarChartGroupData(
          x: 6 - i,
          barRods: [
            BarChartRodData(
              toY: completed ? 1 : 0,
              color: completed ? Colors.green : Colors.red,
              width: 16,
            ),
          ],
        ));
      }
    } else {
      // Show current week
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      for (var i = 0; i < 7; i++) {
        final date = weekStart.add(Duration(days: i));
        final completed = completions.any((c) => 
          c.date.year == date.year && 
          c.date.month == date.month && 
          c.date.day == date.day &&
          c.completed
        );

        groups.add(BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: completed ? 1 : 0,
              color: completed ? Colors.green : Colors.red,
              width: 16,
            ),
          ],
        ));
      }
    }

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 1,
                    minY: 0,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: _getBarGroups(),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final now = DateTime.now();
                            late final DateTime date;
                            
                            if (frequency == HabitFrequency.daily) {
                              date = now.subtract(Duration(days: 6 - value.toInt()));
                            } else {
                              final weekStart = now.subtract(Duration(days: now.weekday - 1));
                              date = weekStart.add(Duration(days: value.toInt()));
                            }
                            
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '${date.day}/${date.month}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
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
