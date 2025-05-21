import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class DataUploadedScreen extends StatelessWidget {
  const DataUploadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xFFA2D88F), // light green background
        body: Stack(children: [
      Container(
        margin: EdgeInsets.only(bottom: context.mediaQuery.size.height * 0.1),
        height: context.mediaQuery.size.height * 0.58,
        color: AppTheme.primaryColorLight,
      ),
      Positioned(
          bottom: 0,
          child: Container(
              width: context.mediaQuery.size.width,
              height: context.mediaQuery.size.height * 0.58,
              alignment: Alignment.bottomCenter,
              child: SuccessScreenCard())),
    ])
        // Center(
        //   child: SuccessScreenCard(),
        // ),
        );
  }
}

class SuccessScreenCard extends StatelessWidget {
  const SuccessScreenCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 32),
      width: context.mediaQuery.size.width * 0.8,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white, // light gray card
          // borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          SizedBox(
            height: 56,
            child: ShowImage(
              imagelink: AppAssets.greenCheckIcon,
            ),
          ),

          const SizedBox(height: 16),
          // Upload Success Text
          Text(
            'Data Uploaded Successfully!',
            style: AppTextStyle.body14Medium600
                .copyWith(color: AppTheme.greenTextDark),
          ),
          const SizedBox(height: 8),
          Text('Data Uploaded',
              style: AppTextStyle.title24MediumClash.copyWith(
                color: Colors.black,
              )),
          const SizedBox(height: 4),
          Text('500 MB',
              style: AppTextStyle.title24MediumClash
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('21st March 2024, 09:52 PM',
              style: AppTextStyle.button12.copyWith(color: AppTheme.greyText)),
          const SizedBox(height: 24),
          // Apply Data Intelligence Button
          SubmitButton(
              onTap: () {
                context.push(AppRoutes.dataIntelligenceScreen);
              },
              label: "Apply Data Intelligence",
              iconAtFront: true,
              color: Colors.black,
              labelColor: Colors.white,
              labelsize: 12,
              icon: const ShowImage(
                  height: 15, imagelink: AppAssets.greenChessIcon)),

          const SizedBox(height: 8),
          // Skip Text
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
