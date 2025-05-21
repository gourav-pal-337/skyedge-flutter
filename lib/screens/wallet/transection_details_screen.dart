import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/authentication/login_screen.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_appbar.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.background,
        appBar: MyAppBar(
          title: "Order xxxx",
          centerTitle: false,
        ),

        //  AppBar(
        //   backgroundColor: colorScheme.background,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        //   title: Text(
        //     'Order xxxx',
        //     style: AppTextStyle.subtitle16SemiBold.copyWith(
        //       color: colorScheme.onBackground,
        //     ),
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRoutes);
                      context.push(AppRoutes.orderHistorysScreen);
                    },
                    child: _buildTopCard(context)),
                const SizedBox(height: 16),
                _buildCard(context, 'Order Details', [
                  _buildRow(context, 'Order Type', 'Stop Limit Order'),
                  _buildRow(context, 'Stop Price', '\$41,145.32/BTC'),
                  _buildRow(context, 'Execution Time', 'April 14, 4:00 PM'),
                ]),
                const SizedBox(height: 16),
                _buildCard(context, 'Payment Details', [
                  _buildRow(context, 'Payment Method', 'Bank Transfer (USD)'),
                  _buildRowWithCopy(context, 'Wallet Address',
                      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
                  _buildRowWithCopy(context, 'Transaction Hash',
                      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
                ]),
                const SizedBox(height: 16),
                _buildCard(context, 'Fee Breakdown', [
                  _buildRow(context, 'Trading Fee', '\$2.05 USD'),
                  _buildRow(context, 'Platform Fee', '\$2.05 USD'),
                  _buildRow(context, 'Total Fees', '\$2.05 USD'),
                ]),
                // const Spacer(),
                50.verticalSpace,
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
        ));
  }

  Widget _buildTopCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You have sent',
                style: AppTextStyle.body14Medium
                    .copyWith(color: AppTheme.greyText),
              ),
              Text(
                '2500.00 USDT',
                style: AppTextStyle.subtitle20Bold
                    .copyWith(color: AppTheme.greenTextColor(context)),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price per token',
                style: AppTextStyle.body14Medium
                    .copyWith(color: AppTheme.greyText),
              ),
              Text(
                '\$41,145.32/BTC',
                style: AppTextStyle.body14Medium,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, List<Widget> children) {
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
            style: AppTextStyle.subtitle16SemiBold,
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
              style:
                  AppTextStyle.body14Medium.copyWith(color: AppTheme.greyText),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: AppTextStyle.body14Medium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithCopy(BuildContext context, String label, String value) {
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
              style:
                  AppTextStyle.body14Medium.copyWith(color: AppTheme.greyText),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: AppTextStyle.body14Medium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.copy, size: 16, color: colorScheme.outline),
              ],
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
              style: AppTextStyle.body14Medium
                  .copyWith(color: colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
