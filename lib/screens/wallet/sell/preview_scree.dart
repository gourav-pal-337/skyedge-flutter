import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/providers/wallet_provider.dart';
import 'package:skyedge/submit_button.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';

class PreviewOrderScreen extends StatelessWidget {
  const PreviewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final walletProv = context.watch<WalletProvider>();
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: MyAppBar(title: 'Preview Order'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: AppTheme.cardBackgroundColor(context),
                // borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You will receive',
                    style: AppTextStyle.body14Regular
                        .copyWith(color: AppTheme.greyText),
                  ),
                  15.verticalSpace,
                  Text(
                    '2500.00 USDT',
                    style: AppTextStyle.subtitle20Bold
                        .copyWith(color: AppTheme.greenTextColor(context)),
                  ),
                  40.verticalSpace,
                  _rowInfo('Token Spent', '10 SKT'),
                  _rowInfo('USDT received', '2500.00 USDT'),
                  _rowInfo('Wallet ID', 'WIS234569'),
                  _rowInfo('Conversion Rate', '1 SKT = 0.99USDT'),
                  _rowInfo('Platform Fee', '0.001 ETH'),
                  _rowInfo('Gas Fee', '~\$0.15'),
                ],
              ),
            ),
            20.verticalSpace,
            Column(
              children: [
                SubmitButton(
                  onTap: () {
                    context.push(AppRoutes.orderCompletionScreen);
                  },
                  label: walletProv.isBuying
                      ? "Continue to Buy"
                      : "Continue to Sell",
                ),
                SubmitButton(
                  onTap: () {
                    context.pop();
                  },
                  label: "Cancel Transaction",
                  color: Colors.transparent,
                  labelColor: AppTheme.errorColor(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _rowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style:
                  AppTextStyle.body14Regular.copyWith(color: AppTheme.greyText),
            ),
          ),
          Text(
            value,
            style: AppTextStyle.body14Medium.copyWith(),
          ),
        ],
      ),
    );
  }
}
