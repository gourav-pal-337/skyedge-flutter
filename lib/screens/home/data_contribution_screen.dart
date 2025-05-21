import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/widgets/contirbution_summary_card.dart';
import 'package:skyedge/screens/home/widgets/contributionn_by_category_card.dart';
import 'package:skyedge/screens/home/widgets/data_intelligence_report_card.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class DataContributionScreen extends StatelessWidget {
  const DataContributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Data Contribution'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContributionSummaryCard(),
              30.verticalSpace,
              _buildGraphSection(context),
              30.verticalSpace,
              ContributionByCategoryCard(),
              30.verticalSpace,
              DataIntelligenceReportCard()
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildGraphSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Contribution Over Time",
        style: AppTextStyle.body16Regular,
      ),
      20.verticalSpace,
      Container(
        padding: const EdgeInsets.all(20),
        color: AppTheme.cardBackgroundColor(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.only(),
              height: 200,

              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const labels = [
                            'Jan',
                            'Feb',
                            'March',
                            'April',
                            'May',
                            // 'June',
                            // 'July',
                            // 'Aug',
                            // 'Sep',
                            // 'Oct',
                            // 'Nov',
                            // 'Dec'
                          ];
                          if (value % 1 == 0 && value ~/ 2 < labels.length) {
                            return Container(
                              // width: ,
                              padding: EdgeInsets.only(left: 15),
                              alignment: Alignment.topRight,
                              child: Text(labels[value.toInt()],
                                  style: Theme.of(context).textTheme.bodySmall),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 20,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          // if (value % 1 == 0) {
                          return Text('${value.toInt()}',
                              style: Theme.of(context).textTheme.bodySmall);
                          // }
                          // return const SizedBox.shrink();
                        },
                        // reservedSize: 40,
                      ),
                    ),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: AppTheme.blue,
                      dotData: FlDotData(
                        show: true,
                        // checkToShowDot: (spot, _) => spot.x == 6,
                        // dotColor: AppTheme.primaryColorLight,
                        // dotSize: 8,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.blue.withOpacity(0.3),
                            Colors.transparent
                          ],
                        ),
                      ),
                      spots: const [
                        FlSpot(0, 25),
                        FlSpot(1, 30.5),
                        FlSpot(2, 75.2),
                        FlSpot(3, 40.3),
                        FlSpot(4, 20.8),
                        // FlSpot(5, 28),
                        // FlSpot(6, 28.5),
                        // FlSpot(7, 30.2),
                        // FlSpot(8, 29.3),
                        // FlSpot(9, 28.8),
                        // FlSpot(10, 29.3),
                        // FlSpot(11, 28.8),
                        // FlSpot(5, 30.1),
                        // FlSpot(6, 31),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ],
  );
}

class _GraphTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _GraphTab({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.grey?.withOpacity(0.8)
            : AppTheme.grey?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }
}
