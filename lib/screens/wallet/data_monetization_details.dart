import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class DataMonetizationDetailsScreen extends StatelessWidget {
  const DataMonetizationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: MyAppBar(title: 'Dataset Purchase Summary'),
      // AppBar(
      //   backgroundColor: colorScheme.background,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: Text(
      //     'Dataset Purchase Summary',
      //     style: AppTextStyle.subtitle16SemiBold.copyWith(
      //       color: colorScheme.onBackground,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCard(
              context,
              title: 'Details',
              children: [
                _buildRow(context, 'Dataset Name:',
                    'Urban Spending\nPatterns - Q1 2025'),
                _buildRow(context, 'Category:', 'Finance'),
                _buildRow(context, 'Buyer:', '@DataMinerPro'),
                _buildRow(context, 'Sold On:', 'May 5, 2025, 10:42 AM'),
                _buildRow(context, 'Tokens Earned:', '+30 SKT'),
              ],
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              title: 'Data Overview',
              children: [
                _buildRow(context, 'Total Records Shared:', '12,5005'),
                _buildRow(context, 'Listed Price:', '35 SKT'),
                _buildRow(context, 'Platform Fee:', '5 SKT'),
                _buildRow(context, 'Your Earnings:', '30 SKT'),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(context, Icons.repeat, 'Repeat Order'),
                _buildActionButton(context, Icons.download, 'Download'),
                _buildActionButton(context, Icons.report, 'Report'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required List<Widget> children}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.subtitle16SemiBold
                .copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: AppTextStyle.body14Medium.copyWith(
                color: AppTheme.greyText,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: AppTextStyle.body14Medium.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: colorScheme.onSurface),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyle.body14Medium.copyWith(
                color: AppTheme.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
