import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/wallet_provider.dart';
import 'package:skyedge/theme/app_theme.dart';

class PaymentMethodSelector extends StatelessWidget {
  final int selectedMethodIndex;
  final VoidCallback onCopyWalletId;
  final Function(int) onMethodChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethodIndex,
    required this.onCopyWalletId,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final walletProv = context.watch<WalletProvider>();
    bool isBuying = walletProv.isBuying;
    final methods = [
      'Connect to MetaMask',
      if (isBuying) 'Verify Transaction Hash'
    ];
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Payment Method',
          style: AppTextStyle.body14Medium.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 10),
        if (isBuying)
          Row(
            children: [
              Text(
                'Wallet id',
                style: AppTextStyle.body14Regular.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.copy,
                  size: 16,
                  color: AppTheme.greyText,
                ),
                onPressed: onCopyWalletId,
                tooltip: 'Copy Wallet ID',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        if (isBuying) ...[
          Text(
            'xxxxxxxxxxxxxxxx',
            style: AppTextStyle.body14Medium.copyWith(letterSpacing: 0.5),
          ),
          const SizedBox(height: 20),
        ],
        ...List.generate(methods.length, (index) {
          final isSelected = selectedMethodIndex == index;
          return GestureDetector(
            onTap: () => onMethodChanged(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? AppTheme.blue : AppTheme.greyText!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? AppTheme.blue : AppTheme.greyText,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    methods[index],
                    style: AppTextStyle.body14Medium.copyWith(
                      color: AppTheme.greyText,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
