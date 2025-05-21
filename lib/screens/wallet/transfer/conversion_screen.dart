import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/submit_button.dart';

class ConnversionScreen extends StatelessWidget {
  const ConnversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MyAppBar(title: 'Convert'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // From Block
              _CurrencyBox(
                label: "From",
                currency: "SUSD",
                amount: "24.00 SUSD",
                balanceText: "Balance: 30.1912343 USDT",
              ),
              const SizedBox(height: 16),

              // Swap Icon
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  )),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Icon(Icons.swap_vert,
                        color: AppTheme.greenTextColor(context)),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  )),
                ],
              ),
              const SizedBox(height: 16),

              // To Block
              _CurrencyBox(
                label: "To",
                currency: "SKT",
                amount: "24.00 SKT",
                balanceText: "Balance: 30.1912343 SKT",
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exchange Rate",
                        style: AppTextStyle.button12
                            .copyWith(color: AppTheme.greyText)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("SUSD/SKT", style: AppTextStyle.button14),
                            Icon(Icons.arrow_drop_down,
                                color: AppTheme.blacktextColor(context)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("4.56678888",
                                style: AppTextStyle.subtitle16SemiBold.copyWith(
                                    color: AppTheme.greenTextColor(context))),
                            // Text(balanceText, style: TextStyle(color: AppTheme.greyText)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              // Exchange Rate
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF1D1D1D),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("SUSD/SKT", style: TextStyle(color: Colors.white70)),
              //       Text("4.56678888", style: TextStyle(color: Colors.white)),
              //     ],
              //   ),
              // ),

              const Spacer(),

              // Convert Button
              SubmitButton(
                  onTap: () {
                    context.push(AppRoutes.tranferCompletionScreen);
                  },
                  isAtBottom: true,
                  label: "Convert"),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFF99CC99),
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(4)),
              //     ),
              //     child: const Text(
              //       "Convert",
              //       style: TextStyle(color: Colors.black, fontSize: 16),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyBox extends StatelessWidget {
  final String label;
  final String currency;
  final String amount;
  final String balanceText;

  const _CurrencyBox({
    required this.label,
    required this.currency,
    required this.amount,
    required this.balanceText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyle.button12.copyWith(color: AppTheme.greyText)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(currency, style: AppTextStyle.button14),
                  Icon(Icons.arrow_drop_down,
                      color: AppTheme.blacktextColor(context)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(amount,
                      style: AppTextStyle.subtitle16SemiBold
                          .copyWith(color: AppTheme.greenTextColor(context))),
                  Text(balanceText, style: TextStyle(color: AppTheme.greyText)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
