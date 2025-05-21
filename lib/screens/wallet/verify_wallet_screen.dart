import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/submit_button.dart';
import 'package:skyedge/theme/app_theme.dart';

class VerifyWalletScreen extends StatefulWidget {
  const VerifyWalletScreen({super.key});

  @override
  State<VerifyWalletScreen> createState() => _VerifyWalletScreenState();
}

class _VerifyWalletScreenState extends State<VerifyWalletScreen> {
  final TextEditingController _hashController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Verfy Wallet',
          style: AppTextStyle.body16Medium.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Verify your Wallet',
                    style: AppTextStyle.subtitle20Medium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Complete verification using your\ntransaction hash',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.caption12Regular
                        .copyWith(color: AppTheme.greyText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBackgroundColor(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: Colors.white60),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'A transaction hash is a unique identifier for a blockchain transaction. You can find it on a block explorer like Etherscan.',
                      style: AppTextStyle.caption12Regular
                          .copyWith(color: AppTheme.greyText),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Transaction Hash',
              style: AppTextStyle.body14Medium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _hashController,
              style: AppTextStyle.body14Regular,
              decoration: InputDecoration(
                hintText: '0x your tx hash',
                hintStyle: AppTextStyle.body14Regular
                    .copyWith(color: AppTheme.greyText),
                filled: true,
                fillColor: AppTheme.cardBackgroundColor(context),
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            const SizedBox(height: 24),
            SubmitButton(
              onTap: () {
                context.pop();
                context.pop();

                final txHash = _hashController.text.trim();
                if (txHash.isNotEmpty) {
                  // perform verification
                }
              },
              label: "Submit Verification",
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.lightGreen.shade400,
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //     ),
            //     onPressed: () {
            //       // Submit hash logic
            // final txHash = _hashController.text.trim();
            // if (txHash.isNotEmpty) {
            //   // perform verification
            // }
            //     },
            //     child: Text(
            //       'Submit Verification',
            //       style:
            //           AppTextStyle.body16Medium.copyWith(color: Colors.black),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
