import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_text_form_field.dart';
import 'package:skyedge/theme/app_theme.dart';

class AdvancedTab extends StatefulWidget {
  const AdvancedTab({super.key});

  @override
  State<AdvancedTab> createState() => _AdvancedTabState();
}

class _AdvancedTabState extends State<AdvancedTab> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBalanceCard(context),
        const SizedBox(height: 20),
        _buildStopTypeSelector(),
        const SizedBox(height: 20),
        MyTextFormField(
          hintText: '0.00',
          suffixWidget: Container(
              padding: const EdgeInsets.only(right: 10),
              width: 100,
              child: const Align(
                  alignment: Alignment.centerRight, child: Text("USDT"))),
          label: "Stop",
        ),
        const SizedBox(height: 16),
        MyTextFormField(
          hintText: '0.00',
          suffixWidget: Container(
              padding: const EdgeInsets.only(right: 10),
              width: 100,
              child: const Align(
                  alignment: Alignment.centerRight, child: Text("USDT"))),
          label: "Limit",
        ),
        const SizedBox(height: 16),
        MyTextFormField(
          hintText: '0.00',
          suffixWidget: Container(
              padding: const EdgeInsets.only(right: 10),
              width: 100,
              child: const Align(
                  alignment: Alignment.centerRight, child: Text("SKT"))),
          label: "Amount",
        ),
        const SizedBox(height: 24),
        _buildFeeSummaryCard(context),
      ],
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,
                  size: 20, color: AppTheme.greyText),
              const SizedBox(width: 8),
              Text(
                'SUSD Balance :',
                style: AppTextStyle.body14Regular
                    .copyWith(color: AppTheme.greyText),
              ),
            ],
          ),
          const Text(
            '1245.00',
            style: AppTextStyle.body14Medium,
          ),
        ],
      ),
    );
  }

  Widget _buildStopTypeSelector() {
    return Row(
      children: [
        _buildRadioButton('Stop Loss', false),
        const SizedBox(width: 20),
        _buildRadioButton('Stop Limit', true),
      ],
    );
  }

  Widget _buildRadioButton(String label, bool isSelected) {
    return Row(
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? Colors.blue : AppTheme.greyText,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyle.body14Medium.copyWith(
            color: isSelected ? Colors.white : AppTheme.greyText,
          ),
        ),
      ],
    );
  }

  Widget _buildFeeSummaryCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryRow(label: 'Conversion Rate', value: '1 USDT = 0.99USD'),
          _SummaryRow(label: 'Platform Fee', value: '0.001 ETH'),
          _SummaryRow(label: 'Stop Limit Price', value: '0.001 USDT'),
          _SummaryRow(label: 'Gas Fee', value: '~\$0.15'),
          Divider(color: Colors.white24, height: 28),
          _SummaryRow(
              label: 'You will Receive', value: '99.85 USDT', isBold: true),
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
