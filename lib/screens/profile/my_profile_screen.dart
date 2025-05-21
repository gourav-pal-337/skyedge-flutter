import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/main.dart';
import 'package:skyedge/screens/profile/verification_screen.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/my_text_form_field.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "My Profile",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppTheme.blacktextColor(context),
                              width: 0.4),
                        ),
                        height: 75,
                        width: 75,
                        child: ShowImage(
                            imagelink:
                                "https://media.licdn.com/dms/image/v2/D4D03AQGfmmtap9UGSw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1668447329811?e=2147483647&v=beta&t=0KlNkR86z7JOy1hLVPWrASGpK72NTRUy26PAxBsZ-QY")),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Name & Wallet
              const Text('F. David', style: AppTextStyle.subtitle18SemiBold),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Wallet ID: 123@xyz',
                      style: AppTextStyle.body14Medium.copyWith(
                        color: AppTheme.greyText,
                      )),
                  const SizedBox(width: 4),
                  Icon(Icons.copy,
                      size: 16, color: AppTheme.blacktextColor(context)),
                ],
              ),
              const SizedBox(height: 24),

              // KYC Status
              isVerified
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackgroundColor(context),
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.verified, color: AppTheme.greenTextDark),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('KYC Status: Verified',
                                    style: AppTextStyle.body14Medium.copyWith(
                                        // color: AppTheme.greyText,
                                        )),
                                const SizedBox(height: 2),
                                Text('Verified on Mar 25, 2025',
                                    style:
                                        AppTextStyle.caption12Regular.copyWith(
                                      color: AppTheme.greyText,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackgroundColor(context),
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kyc Verification required',
                                    style: AppTextStyle.body14Medium.copyWith(
                                        // color: AppTheme.greyText,
                                        )),
                                const SizedBox(height: 2),
                                Text('Complete Your verification',
                                    style:
                                        AppTextStyle.caption12Regular.copyWith(
                                      color: AppTheme.greyText,
                                    )),
                              ],
                            ),
                          ),
                          SubmitButton(
                            onTap: () {
                              // context.push(AppRoutes.verificationScreen);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      const VerificationScreen());
                            },
                            height: 30,
                            label: "Verify Now",
                            labelsize: 11,
                            color: Colors.white,
                            borderColor: AppTheme.blacktextColor(context),
                          )
                        ],
                      ),
                    ),
              const SizedBox(height: 24),

              // Form Fields
              MyTextFormField(
                label: "Full Name",
                hintText: "Enter Full Name",
                initialValue: "8247-3874-2387-0123",
                suffixWidget: Icon(
                  Icons.check,
                  color: AppTheme.greenTextDark,
                ),
              ),

              16.verticalSpace,
              const MyTextFormField(
                label: "Phone Number",
                hintText: "Enter Phone Number",
                initialValue: "+1234 567 8900",
              ),
              16.verticalSpace,

              const MyTextFormField(
                label: "Email",
                hintText: "Enter Email",
                initialValue: "xyz@example.com",
              ),
              16.verticalSpace,

              // _buildInputField('Full Name', '8247-3874-2387-0123',
              //     trailingIcon: Icons.check),
              // _buildInputField('Phone Number', '+1234 567 8900'),
              // _buildInputField('Email', 'xyz@example.com'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value,
      {IconData? trailingIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListTile(
            title: Text(value, style: const TextStyle(color: Colors.white)),
            trailing: trailingIcon != null
                ? Icon(trailingIcon, color: Colors.green)
                : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
