import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/earn/data_categories_screen.dart';
import 'package:skyedge/screens/home/earn/earn_more_bottomsheet.dart';
import 'package:skyedge/screens/questionnaire/welcome_screen.dart';
import 'package:skyedge/theme/app_theme.dart';

class EarnBanner extends StatelessWidget {
  const EarnBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 57,
          decoration: BoxDecoration(
            color: AppTheme.primaryColorDark, // Dark background
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        Container(
          width: double.infinity,
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cardBackgroundColor(context), // Dark background
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glowing icon
              // AnimatedBall(
              //   size: 30,
              // ),
              SizedBox(width: 12),
              Expanded(
                  child: Text(
                "Crush those tasks, earn tokens and",
                style: AppTextStyle.button12,
                maxLines: 1,
              )),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  // showModalBottomSheet(
                  //     isScrollControlled: true,
                  //     backgroundColor: Colors.transparent,
                  //     context: context,
                  // builder: (context) => const EarnMoreBottomsheet());
                  context.push(AppRoutes.questionnaireScreen);
                },
                child: Row(
                  children: [
                    Text(
                      "EARN NOW!",
                      style: AppTextStyle.button10.copyWith(
                          color: AppTheme.primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: AppTheme.primaryColorDark),
                  ],
                ),
              )

              // Main Text
            ],
          ),
        ),
      ],
    );
  }
}
