import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';

class DataIntelligenceReportCard extends StatelessWidget {
  const DataIntelligenceReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Data Intelligence Report',
          style: AppTextStyle.body16Regular,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardBackgroundColor(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar title and percentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Data with Intelligence applied',
                      style: AppTextStyle.caption12Regular),
                  Text('75%', style: AppTextStyle.body14Medium),
                ],
              ),
              const SizedBox(height: 8),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.75,
                  minHeight: 8,
                  backgroundColor: AppTheme.grey?.withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.blueRibbon,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Token Economics header
              Text('Token Economics', style: AppTextStyle.caption12Regular),
              const SizedBox(height: 16),

              // Earned and Spent rows
              _tokenRow(
                  label: 'Earned',
                  value: '1,425 toker',
                  labelcolor: AppTheme.greyText),
              10.verticalSpace,
              _tokenRow(
                  label: 'Spent',
                  value: '890 toker',
                  labelcolor: AppTheme.greyText),

              const Divider(height: 32),

              // Balance row
              _tokenRow(
                  label: 'Balance',
                  value: '890 toker',
                  isBold: true,
                  valuecolor: AppTheme.blue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tokenRow({
    required String label,
    required String value,
    Color? labelcolor,
    Color? valuecolor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.caption12Regular?.copyWith(
            color: labelcolor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.caption12Regular?.copyWith(
            color: valuecolor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
