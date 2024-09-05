import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/grafico_insight.dart';

class LineChartWidget extends StatelessWidget {
  final List<ChartData> ganhouData;
  final List<ChartData> perdeuData;

  LineChartWidget({required this.ganhouData, required this.perdeuData});

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
          child: AnimatedPositionedDirectional(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
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
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  _createLineBarData(ganhouData, Colors.green[300]!, 0),
                  _createLineBarData(
                      perdeuData, Colors.pinkAccent[400]!, ganhouData.length),
                ],
              ),
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
          radius: 6,
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
