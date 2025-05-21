import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/wallet_provider.dart';
import 'package:skyedge/screens/wallet/sell/widgets/select_payment_method.dart';
import 'package:skyedge/theme/app_theme.dart';

class SimpleTab extends StatefulWidget {
  const SimpleTab({super.key});

  @override
  State<SimpleTab> createState() => _SimpleTabState();
}

class _SimpleTabState extends State<SimpleTab> {
  int paymentMethodIndex = 0;
  @override
  Widget build(BuildContext context) {
    final walletProv = context.watch<WalletProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTokenCard(context),
        const SizedBox(height: 24),
        // _buildMetaMaskTile(),
        PaymentMethodSelector(
          onCopyWalletId: () {},
          onMethodChanged: (p0) {
            paymentMethodIndex = p0;
            setState(() {});
          },
          selectedMethodIndex: paymentMethodIndex,
        ),
        const SizedBox(height: 24),
        _buildFeeSummaryCard(),
      ],
    );
  }

  Widget _buildTokenCard(context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _tokenRow(
              context, 'Sell', '\$34567', 'USDT', Icons.currency_exchange),
          Divider(color: AppTheme.grey, height: 28),
          _tokenRow(
              context, 'Receive', '345', 'SKT', Icons.local_fire_department,
              isGreen: true),
        ],
      ),
    );
  }

  Widget _tokenRow(BuildContext context, String label, String value,
      String token, IconData icon,
      {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    AppTextStyle.button12.copyWith(color: AppTheme.greyText)),
            const SizedBox(height: 4),
            Text(value,
                style: AppTextStyle.subtitle16SemiBold
                    .copyWith(color: AppTheme.greenTextColor(context))),
          ],
        ),
        if (label == 'Sell')
          Row(
            children: [
              Icon(icon, color: Colors.blueAccent),
              const SizedBox(width: 4),
              Text(token),
              Icon(Icons.keyboard_arrow_down,
                  color: AppTheme.blacktextColor(context)),
            ],
          )
        else
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.sktIcon,
                color: AppTheme.greenTextColor(context),
              ),
              const SizedBox(width: 4),
              Text(token,
                  style: AppTextStyle.body14Medium
                      .copyWith(color: AppTheme.greenTextColor(context))),
            ],
          )
      ],
    );
  }

  Widget _buildMetaMaskTile() {
    return Column(
      children: [
        const Text(
          'Select Method',
          style: AppTextStyle.body14Medium600,
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.greyText!),
            // borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.radio_button_checked, color: Colors.blue),
              SizedBox(width: 12),
              Text(
                'Connect to MetaMask',
                style: AppTextStyle.body14Regular,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeeSummaryCard() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        // borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryRow(label: 'Conversion Rate', value: '1 USDT = 0.99 USD'),
          _SummaryRow(label: 'Platform Fee', value: '0.001 ETH'),
          _SummaryRow(label: 'Gas Fee', value: '~\$0.15'),
          Divider(color: Colors.white24, height: 28),
          _SummaryRow(
              label: 'You will receive', value: '99.85 USDT', isBold: true),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleValue = AppTextStyle.body14Medium.copyWith(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: isBold ? 14 : 12,
    );

    final textStyleLabel = AppTextStyle.body14Medium.copyWith(
      color: AppTheme.greyText,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: isBold ? 14 : 12,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyleLabel),
          Text(value, style: textStyleValue),
        ],
      ),
    );
  }
}
