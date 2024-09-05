import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barChartData;
  final List<String> titles;

  BarChartWidget({required this.barChartData, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: BarChart(
            BarChartData(
              barGroups: barChartData,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, titleMeta) {
                      final title = titles[value.toInt()];
                      return Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, titleMeta) {
                      return Text(
                        value.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}
