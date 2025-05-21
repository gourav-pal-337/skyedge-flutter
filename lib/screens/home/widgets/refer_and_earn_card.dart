import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/widgets/sky_token_card.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class ReferAndEarnCard extends StatelessWidget {
  const ReferAndEarnCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xFF121212),
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Leaderboard",
            style: AppTextStyle.body16Regular,
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                  decoration:
                      const BoxDecoration(color: AppTheme.blue // Soft green
                          // borderRadius: BorderRadius.circular(8),
                          ),
                  child: CustomPaint(
                    painter: const TopographicTexturePainter(
                        textureColor: Colors.white),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 35),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Earn More With Referrals",
                                    style: AppTextStyle.title28BoldCllash
                                        .copyWith(
                                            color: AppTheme.primaryColorDark),
                                  ),
                                  Text(
                                      "Invite friends and earn 10% of their earnings",
                                      style: AppTextStyle.body14Regular
                                          .copyWith(color: Colors.white)),
                                  25.verticalSpace,
                                  SubmitButton(
                                      onTap: () {
                                        context
                                            .push(AppRoutes.referAndEarnScreen);
                                      },
                                      width: 150,
                                      height: 36,
                                      labelStyle:
                                          AppTextStyle.body14Medium.copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      color: Colors.white,
                                      label: "View All")
                                ],
                              )),
                          Expanded(flex: 3, child: SizedBox())
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                      width: 100,
                      child: ShowImage(imagelink: AppAssets.skyCoin)))
            ],
          )
        ],
      ),
    );
  }
}
