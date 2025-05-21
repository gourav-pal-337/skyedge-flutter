import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/profile/kyc_result_sheet.dart';
import 'package:skyedge/screens/profile/widgets/upload_image_box.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_text_form_field.dart';
import 'package:skyedge/widgets/submit_button.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = Colors.grey.withOpacity(0.5);

    // Widget uploadBox(String label) {
    //   return DottedBorder(
    //     color: Colors.white54,
    //     strokeWidth: 1.2,
    //     dashPattern: [6, 4],
    //     borderType: BorderType.RRect,
    //     radius: const Radius.circular(8),
    //     child: Container(
    //       height: 130,
    //       width: double.infinity,
    //       margin: const EdgeInsets.all(8),
    //       padding: const EdgeInsets.all(12),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Icon(Icons.cloud_upload_outlined,
    //               color: Colors.white, size: 28),
    //           const SizedBox(height: 8),
    //           Text(label, style: const TextStyle(color: Colors.white)),
    //           const SizedBox(height: 4),
    //           const Text(
    //             'JPG, PNG (max 5MB)',
    //             style: TextStyle(fontSize: 12, color: Colors.white60),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget section({
      required String title,
      required String subtitle,
      required String textFieldLabel,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(title, style: AppTextStyle.subtitle18Bold),
          const SizedBox(height: 4),
          Text(subtitle,
              style: AppTextStyle.caption12Regular
                  .copyWith(color: AppTheme.greyText)),
          20.verticalSpace,
          MyTextFormField(hintText: "Enter your ID number"),
          // TextField(
          //   decoration: InputDecoration(
          //     labelText: textFieldLabel,
          //     labelStyle: const TextStyle(color: Colors.white70),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: borderColor),
          //     ),
          //     focusedBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.white),
          //     ),
          //   ),
          //   style: const TextStyle(color: Colors.white),
          // ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: UploadImageBox(title: "Upload front side")),
              10.horizontalSpace,
              Expanded(child: UploadImageBox(title: "Upload back side")),
              // uploadBox("Upload front side"),
              // uploadBox("Upload back side"),
            ],
          ),
        ],
      );
    }

    Color foregroundColor = AppTheme.isDarkMode(context)
        ? AppTheme.foregroundColorDark
        : AppTheme.foregroundColorLight;

    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: context.mediaQuery.size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Let's Get You Verified",
                          style: AppTextStyle.title24MediumClash),
                      section(
                        title: "Government ID verification",
                        subtitle:
                            "Please enter your ID number and upload clear images of both sides",
                        textFieldLabel: "Enter your ID number",
                      ),
                      section(
                        title: "Tax ID verification",
                        subtitle:
                            "Please enter your ID number and upload clear images of both sides",
                        textFieldLabel: "Enter your ID number",
                      ),
                      section(
                        title: "Tax ID verification",
                        subtitle:
                            "Please enter your ID number and upload clear images of both sides",
                        textFieldLabel: "Enter your ID number",
                      ),
                    ],
                  ),
                ),
              ),
              SubmitButton(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => KycResultScreen(
                              isVerified: false,
                            ));
                  },
                  label: "Continue to sell"),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
