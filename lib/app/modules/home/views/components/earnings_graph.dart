import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticker_assign/app/data/models/earnings_model.dart';

class EarningsGraph extends StatelessWidget {
  final List<EarningsData> data;

  const EarningsGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final sortedData = List<EarningsData>.from(data)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Format for displaying dates
    final dateFormat = DateFormat('MMM yyyy');
    
    // Calculate min and max values for better scaling
    final minEPS = sortedData.map((e) => e.estimatedEPS).reduce((a, b) => a < b ? a : b);
    final maxEPS = sortedData.map((e) => e.estimatedEPS).reduce((a, b) => a > b ? a : b);
    
    // Add some padding to the min/max values
    final epsInterval = (maxEPS - minEPS) * 0.1;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(color: Colors.blue, label: 'Estimated EPS'),
                SizedBox(width: 20),
                _LegendItem(color: Colors.red, label: 'Actual EPS'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                minY: minEPS - epsInterval,
                maxY: maxEPS + epsInterval,
                lineBarsData: [
                  // Estimated EPS Line
                  LineChartBarData(
                    spots: sortedData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.estimatedEPS);
                    }).toList(),
                    color: Colors.blue,
                    dotData: const FlDotData(show: true),
                    isCurved: true,
                  ),
                  // Actual EPS Line
                  LineChartBarData(
                    spots: sortedData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.actualEPS);
                    }).toList(),
                    color: Colors.red,
                    dotData: const FlDotData(show: true),
                    isCurved: true,
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < sortedData.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dateFormat.format(sortedData[index].date),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 40,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            value.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      reservedSize: 45,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        final data = sortedData[spot.x.toInt()];
                        final isEstimated = spot.barIndex == 0;
                        return LineTooltipItem(
                          '${dateFormat.format(data.date)}\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${isEstimated ? "Estimated" : "Actual"} EPS: \$${spot.y.toStringAsFixed(2)}\n',
                              style: TextStyle(
                                color: isEstimated ? Colors.blue : Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: '${isEstimated ? "Estimated" : "Actual"} Revenue: \$${NumberFormat.compact().format(isEstimated ? data.estimatedRevenue : data.actualRevenue)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                  handleBuiltInTouches: true,
                  touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                    if (event is FlTapUpEvent && response?.lineBarSpots != null && response!.lineBarSpots!.isNotEmpty) {
                      final spotIndex = response.lineBarSpots!.first.x.toInt();
                      if (spotIndex >= 0 && spotIndex < sortedData.length) {
                        final selectedData = sortedData[spotIndex];
                        final quarter = _getQuarter(selectedData.date);
                        final year = selectedData.date.year;
                        
                        Get.toNamed(
                          '/transcript',
                          arguments: {
                            'ticker': selectedData.ticker,
                            'year': year,
                            'quarter': quarter,
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  _getQuarter(DateTime date) {
    return (date.month / 3).ceil();
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}