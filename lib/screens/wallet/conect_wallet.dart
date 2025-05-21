import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/submit_button.dart';
import 'package:skyedge/theme/app_theme.dart';

class ConnectWalletScreen extends StatelessWidget {
  const ConnectWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: 'Connect Wallet'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.cardBackgroundColor(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Icon(Icons.account_balance_wallet_outlined,
                      size: 40, color: Colors.white70),
                  const SizedBox(height: 12),
                  const Text(
                    '0xABCxxxxx456',
                    style: AppTextStyle.body16Medium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Is this your correct wallet address?',
                    style: AppTextStyle.body14Regular
                        .copyWith(color: AppTheme.greyText),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SubmitButton(
              onTap: () {
                context.push(AppRoutes.verifyWalletScreen);
              },
              label: "Confirm & Proceed",
            ),
            SubmitButton(
              onTap: () {
                context.pop();
              },
              label: "Connect Different Wallet",
              color: Colors.transparent,
              labelColor: AppTheme.blue,
            ),
          ],
        ),
      ),
    );
  }
}
