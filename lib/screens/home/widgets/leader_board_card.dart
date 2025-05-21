import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/widgets/sky_token_card.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class LeaderboardCard extends StatelessWidget {
  final int currentRank;
  final String message;
  final VoidCallback onPressed;

  const LeaderboardCard({
    super.key,
    required this.currentRank,
    required this.message,
    required this.onPressed,
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFB4DA8D), // Soft green
                    // borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomPaint(
                    painter: const TopographicTexturePainter(),
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
                                    "Current Rank: $currentRank",
                                    style: AppTextStyle.title28BoldCllash
                                        .copyWith(color: AppTheme.blue),
                                  ),
                                  Text("You're in the top 100 data provider",
                                      style: AppTextStyle.body14Regular
                                          .copyWith(color: Colors.black)),
                                  25.verticalSpace,
                                  SubmitButton(
                                      onTap: () {},
                                      width: 150,
                                      height: 36,
                                      labelStyle:
                                          AppTextStyle.body14Medium.copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      color: Colors.white,
                                      label: "Upload & Rank up ")
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
