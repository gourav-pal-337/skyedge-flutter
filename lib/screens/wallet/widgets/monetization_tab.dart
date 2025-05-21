import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class MonetizationScreen extends StatelessWidget {
  const MonetizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list,
                  color: AppTheme.blacktextColor(context)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text('Filter',
                    style: TextStyle(color: AppTheme.blacktextColor(context))),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            itemBuilder: (context, index) {
              final isResume = index == 1;
              return GestureDetector(
                onTap: () {
                  context.push(AppRoutes.dataMonetizationDetailsScreen);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/7/75/Zomato_logo.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Zomato',
                                style: AppTextStyle.subtitle16SemiBold),
                            SizedBox(height: 4),
                            Text('March 15, 2025, 2:30 PM',
                                style: AppTextStyle.caption12Regular
                                    .copyWith(color: AppTheme.greyText)),
                            SizedBox(height: 8),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'Data Shared: ',
                                  style: AppTextStyle.caption12Medium
                                      .copyWith(color: AppTheme.greyText)),
                              TextSpan(
                                  text: 'Food Order History',
                                  style: AppTextStyle.caption12Medium)
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'Pay Out: ',
                                  style: AppTextStyle.caption12Medium
                                      .copyWith(color: AppTheme.greyText)),
                              TextSpan(
                                  text: 'March 2, 2025',
                                  style: AppTextStyle.caption12Medium)
                            ])),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('45.2 \$SKYE',
                              style: AppTextStyle.body14Medium600
                                  .copyWith(color: AppTheme.blue)),
                          const SizedBox(height: 8),
                          Text(
                            isResume ? 'Resume' : 'Stop Sharing',
                            style: TextStyle(
                              color: isResume
                                  ? AppTheme.greenTextColor(context)
                                  : Colors.redAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
