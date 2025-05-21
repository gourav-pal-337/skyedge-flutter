import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/show_image.dart';

class DataSetsCategoryScreen extends StatelessWidget {
  const DataSetsCategoryScreen({super.key});

  final List<Map<String, dynamic>> dataSets = const [
    {
      "title": "Finance",
      "date": "Mar 15, 2025",
      "size": "3 MB",
      "icon": AppAssets.financeIcon,
    },
    {
      "title": "Health",
      "date": "Mar 15, 2025",
      "size": "5 MB",
      "icon": AppAssets.healthIcon,
    },
    {
      "title": "Education",
      "date": "Mar 15, 2025",
      "size": "3 MB",
      "icon": AppAssets.educationIcon,
    },
    {
      "title": "Social Media",
      "date": "Mar 15, 2025",
      "size": "3 MB",
      "icon": AppAssets.socialIcon,
    },
    {
      "title": "Shopping",
      "date": "Mar 15, 2025",
      "size": "3 MB",
      "icon": AppAssets.shoppingIcon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MyAppBar(title: 'Data Sets'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar

              const SizedBox(height: 24),

              // List of data sets
              Expanded(
                child: ListView.separated(
                  itemCount: dataSets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = dataSets[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.dataSetSubCategoryScreen);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffB9DCFF),
                              ),
                              alignment: Alignment.center,
                              child: ShowImage(
                                height: 20,
                                width: 20,
                                imagelink: item['icon'],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title'],
                                      style: AppTextStyle.body14Medium),
                                  const SizedBox(height: 4),
                                  Text(item['date'],
                                      style: AppTextStyle.button12
                                          .copyWith(color: AppTheme.greyText)),
                                ],
                              ),
                            ),
                            Text(item['size'],
                                style: AppTextStyle.button12
                                    .copyWith(color: AppTheme.greyText)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
