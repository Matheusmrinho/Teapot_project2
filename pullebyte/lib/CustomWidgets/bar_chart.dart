import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barChartData;
  final List<String> titles;
  final Map<String, Color> legends; // Mapa para as legendas e cores

  BarChartWidget({
    required this.barChartData,
    required this.titles,
    required this.legends, // Recebe as legendas e cores
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customColorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: customColorScheme.secondary,
          borderRadius: BorderRadius.circular(15), // Adiciona o borderRadius
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Perdas e Ganhos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: BarChart(
                  BarChartData(
                    barGroups: barChartData,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 40,
                          showTitles: true,
                          getTitlesWidget: (value, titleMeta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: customColorScheme.onPrimary,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: legends.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: entry.value,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          entry.key,
                          style: TextStyle(
                            color: customColorScheme.onPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
