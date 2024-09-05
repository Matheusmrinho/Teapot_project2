import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/grafico_insight.dart';
import 'package:pullebyte/theme/colors.dart';

class LineChartWidget extends StatelessWidget {
  final List<ChartData> ganhouData;
  final List<ChartData> perdeuData;

  LineChartWidget({required this.ganhouData, required this.perdeuData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customColorScheme.surface, // Fundo do gráfico com cor surface
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordas arredondadas
      ),
      elevation: 5,
      child: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      final isGanhou = spot.barIndex == 0;
                      final data = isGanhou
                          ? ganhouData[spot.x.toInt()]
                          : perdeuData[spot.x.toInt() - ganhouData.length];
                      return LineTooltipItem(
                        '${data.title}\nValor: ${data.averageValue.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: customColorScheme.onPrimary,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: customColorScheme.onPrimary,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Desativa os títulos no fundo
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Desativa os títulos à direita
                  ),
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: customColorScheme.onSecondary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              lineBarsData: [
                _createLineBarData(ganhouData, Colors.green[300]!, 0),
                _createLineBarData(
                    perdeuData, Colors.pinkAccent[400]!, ganhouData.length),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartBarData _createLineBarData(List<ChartData> data, Color color,
      [int offset = 0]) {
    return LineChartBarData(
      spots: data
          .asMap()
          .entries
          .map((e) => FlSpot((e.key + offset).toDouble(), e.value.averageValue))
          .toList(),
      isCurved: true,
      color: color,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
          radius: 4,
          color: color,
          strokeWidth: 2,
          strokeColor: Colors.white,
        ),
      ),
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.3),
      ),
    );
  }
}
