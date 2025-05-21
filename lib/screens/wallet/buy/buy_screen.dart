import 'package:flutter/material.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/constants/app_textstyle.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  int selectedTab = 0;
  int selectedMode = 0;
  int selectedPayment = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme.isDarkMode(context);
    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundColorDark : AppTheme.backgroundColorLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: AppTheme.whitetextColor(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Buy',
            style: AppTextStyle.title24Medium
                .copyWith(color: AppTheme.whitetextColor(context))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Current Value',
              style:
                  AppTextStyle.body16Medium.copyWith(color: AppTheme.greyText),
            ),
            const SizedBox(height: 8),
            Text(
              '1 Token = 2.4 USDT',
              style: AppTextStyle.title24Bold
                  .copyWith(color: AppTheme.whitetextColor(context)),
            ),
            Text(
              '+2.60%',
              style: AppTextStyle.body16Medium
                  .copyWith(color: AppTheme.primaryColorLight),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                4,
                (i) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(['1D', '1W', '1M', '1Y'][i],
                        style: AppTextStyle.body16Medium.copyWith(
                            color: selectedTab == i
                                ? Colors.black
                                : AppTheme.whitetextColor(context))),
                    selected: selectedTab == i,
                    onSelected: (_) => setState(() => selectedTab = i),
                    selectedColor: AppTheme.primaryColorLight,
                    backgroundColor: AppTheme.surfaceColorDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Placeholder for the graph
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColorDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Graph Here',
                  style: AppTextStyle.body16Medium
                      .copyWith(color: AppTheme.greyText),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Simple/Advanced toggle
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedMode = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedMode == 0
                            ? AppTheme.primaryColorLight
                            : AppTheme.surfaceColorDark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('Simple',
                          style: AppTextStyle.body16Medium.copyWith(
                              color: selectedMode == 0
                                  ? Colors.black
                                  : AppTheme.whitetextColor(context))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedMode = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedMode == 1
                            ? AppTheme.primaryColorLight
                            : AppTheme.surfaceColorDark,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('Advanced',
                          style: AppTextStyle.body16Medium.copyWith(
                              color: selectedMode == 1
                                  ? Colors.black
                                  : AppTheme.whitetextColor(context))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Buy/Receive section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColorDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Buy',
                              style: AppTextStyle.body16Medium
                                  .copyWith(color: AppTheme.primaryColorLight)),
                          Text('34567',
                              style: AppTextStyle.title24Bold
                                  .copyWith(color: AppTheme.primaryColorLight)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('USDT',
                              style: AppTextStyle.body16Medium.copyWith(
                                  color: AppTheme.whitetextColor(context))),
                          const SizedBox(width: 4),
                          Icon(Icons.monetization_on,
                              color: AppTheme.primaryColorLight),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Receive',
                              style: AppTextStyle.body16Medium
                                  .copyWith(color: AppTheme.primaryColorLight)),
                          Text('345',
                              style: AppTextStyle.title24Bold
                                  .copyWith(color: AppTheme.primaryColorLight)),
                        ],
                      ),
                      Text('SKT',
                          style: AppTextStyle.body16Medium.copyWith(
                              color: AppTheme.whitetextColor(context))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Select Payment Method',
                style: AppTextStyle.body16Medium
                    .copyWith(color: AppTheme.whitetextColor(context))),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Wallet id',
                    style: AppTextStyle.body16Medium
                        .copyWith(color: AppTheme.greyText)),
                const Spacer(),
                Icon(Icons.copy, color: AppTheme.primaryColorLight, size: 18),
              ],
            ),
            Text('xxxxxxxxxxxxxxx',
                style: AppTextStyle.body16Medium
                    .copyWith(color: AppTheme.whitetextColor(context))),
            const SizedBox(height: 12),
            Column(
              children: [
                GestureDetector(
                  onTap: () => setState(() => selectedPayment = 0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: selectedPayment == 0
                          ? AppTheme.primaryColorLight.withOpacity(0.15)
                          : AppTheme.surfaceColorDark,
                      border: Border.all(
                          color: selectedPayment == 0
                              ? AppTheme.primaryColorLight
                              : AppTheme.surfaceColorDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_wallet,
                            color: AppTheme.primaryColorLight),
                        const SizedBox(width: 12),
                        Text('Connect to MetaMask',
                            style: AppTextStyle.body16Medium.copyWith(
                                color: AppTheme.whitetextColor(context))),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => selectedPayment = 1),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    decoration: BoxDecoration(
                      color: selectedPayment == 1
                          ? AppTheme.primaryColorLight.withOpacity(0.15)
                          : AppTheme.surfaceColorDark,
                      border: Border.all(
                          color: selectedPayment == 1
                              ? AppTheme.primaryColorLight
                              : AppTheme.surfaceColorDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.verified, color: AppTheme.primaryColorLight),
                        const SizedBox(width: 12),
                        Text('Verify Transaction Hash',
                            style: AppTextStyle.body16Medium.copyWith(
                                color: AppTheme.whitetextColor(context))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColorDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Conversion Rate',
                          style: AppTextStyle.body16Medium
                              .copyWith(color: AppTheme.greyText)),
                      Text('1 USDT = 0.99 USD',
                          style: AppTextStyle.body16Medium.copyWith(
                              color: AppTheme.whitetextColor(context))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Platform Fee',
                          style: AppTextStyle.body16Medium
                              .copyWith(color: AppTheme.greyText)),
                      Text('0.001 ETH',
                          style: AppTextStyle.body16Medium.copyWith(
                              color: AppTheme.whitetextColor(context))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gas Fee',
                          style: AppTextStyle.body16Medium
                              .copyWith(color: AppTheme.greyText)),
                      Text('0.15',
                          style: AppTextStyle.body16Medium.copyWith(
                              color: AppTheme.whitetextColor(context))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('You will Receive',
                          style: AppTextStyle.body16Medium
                              .copyWith(color: AppTheme.greyText)),
                      Text('99.85 USDT',
                          style: AppTextStyle.body16Medium
                              .copyWith(color: AppTheme.primaryColorLight)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColorLight,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text('Continue to Buy',
                    style: AppTextStyle.body16Medium
                        .copyWith(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
