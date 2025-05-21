import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';

class ContributionByCategoryCard extends StatelessWidget {
  const ContributionByCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final data = [
      _PieData('Financial', 50, AppTheme.blueRibbon),
      _PieData('Health', 25, Color(0xff9BDFC4)),
      _PieData('Health', 25, Color(0XFFFFB44F)),
      _PieData('Others', 25, Color(0xffF99BAB)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contribution By Category',
          style: AppTextStyle.body16Regular,
        ),
        20.verticalSpace,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          decoration: BoxDecoration(
            color: AppTheme.cardBackgroundColor(context),
          ),
          child: Column(
            children: [
              20.verticalSpace,
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 70,
                        sections: data.map((e) {
                          return PieChartSectionData(
                            value: e.value.toDouble(),
                            color: e.color,
                            radius: 30,
                            showTitle: false,
                          );
                        }).toList(),
                      ),
                    ),
                    Text(
                      '2 GB',
                      style: AppTextStyle.subtitle18Regular?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: data.map((e) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: e.color,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              e.label,
                              style: AppTextStyle.caption12Regular?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${e.value}%',
                          style: AppTextStyle.caption12Regular?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PieData {
  final String label;
  final int value;
  final Color color;

  _PieData(this.label, this.value, this.color);
}
