import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/submit_button.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_text_form_field.dart';

class TransferScreen extends StatelessWidget {
  final TextEditingController walletController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Transfer'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back and Title

              SizedBox(height: 24),

              // Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackgroundColor(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("00 SUSD", style: AppTextStyle.subtitle16SemiBold),
                        SizedBox(height: 4),
                        Text("Available Balance",
                            style: AppTextStyle.button12
                                .copyWith(color: AppTheme.greyText)),
                      ],
                    ),
                    Text("Buy",
                        style: AppTextStyle.subtitle16SemiBold
                            .copyWith(color: AppTheme.greenTextColor(context))),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Wallet Input

              MyTextFormField(
                hintText: "8247-3874-2387-012",
                label: "Enter Wallet ID or",
                suffixWidget:
                    Icon(Icons.qr_code_scanner, color: Colors.greenAccent),
              ),

              SizedBox(height: 24),

              // Amount Input
              MyTextFormField(
                hintText: "Enter Amount",
                label: "Enter Amount",
              ),
              Spacer(),

              // Continue Button
              SubmitButton(
                  onTap: () {
                    context.push(AppRoutes.tranferCompletionScreen);
                  },
                  isAtBottom: true,
                  label: "Continue to Transfer"),
            ],
          ),
        ),
      ),
    );
  }
}
