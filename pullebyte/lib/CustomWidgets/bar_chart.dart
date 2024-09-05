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
                      // Ajuste para truncar longas labels e simplificar
                      return Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          title.length > 6
                              ? '${title.substring(0, 6)}...'
                              : title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize:
                        40, // Mais espaçamento para as labels da esquerda
                    getTitlesWidget: (value, titleMeta) {
                      return Text(
                        value.toInt().toString(), // Mostrar valores inteiros
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 10,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.5),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barTouchData: BarTouchData(enabled: false),
              maxY:
                  100, // Definir um valor máximo para controlar a altura das barras
            ),
          ),
        ),
      ),
    );
  }
}
