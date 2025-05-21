import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';

class KycResultScreen extends StatelessWidget {
  final bool isVerified;

  const KycResultScreen({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = AppTheme.isDarkMode(context)
        ? AppTheme.foregroundColorDark
        : AppTheme.foregroundColorLight;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              30.verticalSpace,
              GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: foregroundColor.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.close,
                      color: foregroundColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowImage(
                        imagelink: isVerified
                            ? 'https://cdn-icons-png.flaticon.com/512/9918/9918694.png' // Blue badge with check
                            : 'https://cdn3d.iconscout.com/3d/premium/thumb/not-approved-3d-illustration-download-in-png-blend-fbx-gltf-file-formats--remove-cancel-canceled-accepted-reject-verified-pack-sign-symbols-illustrations-4409991.png?f=webp',
                        boxFit: BoxFit.contain, // Red badge with cross
                        height: 160,
                      ),
                      const SizedBox(height: 40),
                      Text(
                          isVerified
                              ? "You're Verified!"
                              : "KYC Verification Failed",
                          style: AppTextStyle.subtitle20Medium),
                      const SizedBox(height: 12),
                      Text(
                        isVerified
                            ? "Your KYC is complete — you’re all set to buy,\nsell, and transfer SkyTokens."
                            : "We couldn’t verify your details. Please check\nyour info and try again.",
                        style: AppTextStyle.body14Regular
                            .copyWith(color: AppTheme.greyText),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
              // const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isVerified) {
                      // Handle explore action
                    } else {
                      // Handle retry KYC action
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB5E5A4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isVerified ? "Start Exploring" : "Retry KYC",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
