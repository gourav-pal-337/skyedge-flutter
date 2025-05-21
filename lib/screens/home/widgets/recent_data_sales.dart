import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class RecentDataSalesWidget extends StatelessWidget {
  const RecentDataSalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Data Sales",
                style: AppTextStyle.body16Regular,
              ),
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.dataSetCategoryScreen);
                },
                child: Text(
                  "See all",
                  style:
                      AppTextStyle.button14.copyWith(color: AppTheme.greyText),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Data Sales List
          Column(
            children: List.generate(3, (index) => const DataSaleTile()),
          )
        ],
      ),
    );
  }
}

class DataSaleTile extends StatelessWidget {
  const DataSaleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white10,
              // borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.shield, color: AppTheme.blacktextColor(context)),
          ),
          const SizedBox(width: 12),
          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health & Fitness Data",
                  style: AppTextStyle.body14Medium,
                ),
                SizedBox(height: 4),
                Text(
                  "Acme Corp",
                  style: AppTextStyle.caption12Medium
                      .copyWith(color: AppTheme.greyText),
                ),
              ],
            ),
          ),
          // Amount and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "45.2 \$SKYE",
                style: TextStyle(color: AppTheme.primaryColorDark),
              ),
              const SizedBox(height: 4),
              Text(
                "Today",
                style: AppTextStyle.caption12Medium
                    .copyWith(color: AppTheme.greyText),
              ),
            ],
          )
        ],
      ),
    );
  }
}
