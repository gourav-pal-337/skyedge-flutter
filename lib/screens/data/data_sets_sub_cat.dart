import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/submit_button.dart';

class DataSetsSubCategoryScreenn extends StatefulWidget {
  const DataSetsSubCategoryScreenn({super.key});

  @override
  State<DataSetsSubCategoryScreenn> createState() =>
      _DataSetsSubCategoryScreennState();
}

class _DataSetsSubCategoryScreennState
    extends State<DataSetsSubCategoryScreenn> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> dataItems = [
    {
      "title": "E-wallet logs",
      "type": "Raw",
      "size": "2.5 MB",
      "date": "Mar 15, 2025",
      "intelligent": false,
    },
    {
      "title": "Bank statements",
      "type": "Intelligent",
      "size": "2.5 MB",
      "date": "Mar 15, 2025",
      "intelligent": true,
    },
    {
      "title": "Bank statements",
      "type": "Intelligent",
      "size": "2.5 MB",
      "date": "Mar 15, 2025",
      "intelligent": true,
    },
    {
      "title": "E-wallet logs",
      "type": "Raw",
      "size": "2.5 MB",
      "date": "Mar 15, 2025",
      "intelligent": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedFilter == 'All'
        ? dataItems
        : dataItems.where((item) => item['type'] == selectedFilter).toList();
    final schemeColor = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(title: 'Fiancial Data'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header

              const SizedBox(height: 20),

              // Filter Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: ['All', 'Raw', 'Data Intelligence'].map((filter) {
                  final bool isSelected = selectedFilter == filter;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        color: schemeColor.surfaceContainerHighest,
                        border: Border.all(
                            color: isSelected
                                ? AppTheme.greenTextColor(context)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(filter,
                        style: AppTextStyle.subtitle16SemiBold
                            .copyWith(color: AppTheme.blacktextColor(context))),
                  );
                }).toList(),
              ),
              20.verticalSpace,

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                    color: schemeColor.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppTheme.greenTextColor(context), size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Only intelligent datasets are shareable in the marketplace. Raw data is for your view only.",
                        style: AppTextStyle.button12
                            .copyWith(color: AppTheme.greyText),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              // Data cards
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: schemeColor.surfaceContainerHighest,
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title'],
                              style: AppTextStyle.body16Medium
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text(
                            "Monthly billing statement (PDF)",
                            style: AppTextStyle.button12,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item['type'],
                                  style: AppTextStyle.button12
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['size'],
                                style: AppTextStyle.button12
                                    .copyWith(color: AppTheme.greyText),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['date'],
                                style: AppTextStyle.button12
                                    .copyWith(color: AppTheme.greyText),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                  child: SubmitButton(
                                      onTap: () {
                                        context.push(
                                            AppRoutes.bankStatementScreen);
                                      },
                                      height: 36,
                                      color: Colors.transparent,
                                      borderColor:
                                          AppTheme.greenTextColor(context),
                                      labelColor:
                                          AppTheme.greenTextColor(context),
                                      labelsize: 12,
                                      label: "Preview")),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: !item['intelligent']
                                      ? SubmitButton(
                                          onTap: () {},
                                          height: 36,
                                          labelsize: 12,
                                          label: "Apply Intelligence")
                                      : const SizedBox()),
                            ],
                          ),
                        ],
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
