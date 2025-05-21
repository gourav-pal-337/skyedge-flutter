import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';

class ContributionSummaryCard extends StatelessWidget {
  const ContributionSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
          color: AppTheme.cardBackgroundColor(context),
          // borderRadius: BorderRadius.circular(16),
          border: Border(
              bottom: BorderSide(color: AppTheme.primaryColorLight, width: 1))),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contributed & Tokens Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DataBlock(
                title: 'Total Contributed',
                value: '275 MB',
                usdValue: '\$1299 USD',
              ),
              _DataBlock(
                title: 'Total Tokens',
                value: '1425',
                usdValue: '\$1299 USD',
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              const Icon(Icons.workspace_premium_rounded, color: Colors.amber),
              5.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data Pioneer',
                        style: AppTextStyle.caption12Regular),
                    5.verticalSpace,

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: 275 / (275 + 70), // current / total goal
                        minHeight: 10,
                        backgroundColor: AppTheme.grey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.blueRibbon),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ), // Badge Row

          const SizedBox(height: 12),

          // Bottom Text
          Center(
            child: Text(
              'Contribute 70 Mb more to reach Gold Badge!',
              style: AppTextStyle.body14Medium,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class _DataBlock extends StatelessWidget {
  final String title;
  final String value;
  final String usdValue;

  const _DataBlock({
    required this.title,
    required this.value,
    required this.usdValue,
  });

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.body14Regular),
        const SizedBox(height: 4),
        Text(value,
            style: AppTextStyle.title24MediumClash
                .copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          usdValue,
          style: AppTextStyle.body16Small,
        ),
      ],
    );
  }
}
