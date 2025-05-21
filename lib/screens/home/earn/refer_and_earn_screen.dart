import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF111111),
      appBar: MyAppBar(title: 'Refer & Earn'),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: const Icon(Icons.arrow_back, color: Colors.white),
      //   title: const Text(
      //     'Refer & Earn',
      //     style: TextStyle(color: Colors.white, fontSize: 18),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Placeholder for the illustration
            SizedBox(
              height: 300,
              child: ShowImage(
                imagelink: AppAssets.referAndEarn,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Refer & Earn – Connect, Share\n& Earn More!',
              style: AppTextStyle.subtitle16SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Referral code field
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.cardBackgroundColor(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Referral Code",
                    style: AppTextStyle.caption12Regular.copyWith(
                      color: AppTheme.greyText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.grey?.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'EDGE123',
                            style: AppTextStyle.subtitle20Medium,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.copy,
                              size: 20,
                              color: AppTheme.blacktextColor(context)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SubmitButton(onTap: () {}, label: "Continue to sell"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stat Cards
            _statCard(
                context, AppAssets.friendReferred, '12', 'Friends Referred'),
            const SizedBox(height: 12),
            _statCard(
                context, AppAssets.pendingReward, 'SKT 40', 'Pending Rewards'),
            const SizedBox(height: 12),
            _statCard(
                context, AppAssets.earnedReward, 'SKT 60', 'Earned Rewards'),
            const SizedBox(height: 32),

            // How it works section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'How it Works?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _howItWorksItem(
                1, 'Share Your Referral Code', 'Invite your friends to join.'),
            const SizedBox(height: 12),
            _howItWorksItem(2, 'They Sign Up & Share',
                'Your referral must complete their data share.'),
            const SizedBox(height: 12),
            _howItWorksItem(3, 'You Earn Rewards!',
                'Get SKT XXX for every successful referral.'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _statCard(context, String icon, String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        // borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(icon, color: Colors.white, size: 28),
          ShowImage(
            height: 30,
            imagelink: icon,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyle.body16Medium),
              const SizedBox(height: 4),
              Text(label,
                  style: AppTextStyle.caption12Medium
                      .copyWith(color: AppTheme.greyText)),
            ],
          )
        ],
      ),
    );
  }

  Widget _howItWorksItem(int index, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Color(0xFFB9DCFF), shape: BoxShape.circle),
          child: Text(
            index.toString(),
            style: AppTextStyle.body14Medium.copyWith(color: AppTheme.blue),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.body14Medium),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: AppTextStyle.body14Regular
                      .copyWith(color: AppTheme.greyText)),
            ],
          ),
        )
      ],
    );
  }
}
