import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class QuestionnaireCompletionScreen extends StatelessWidget {
  const QuestionnaireCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: SunburstPainter(),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0),
                      ),
                    ),
                    onPressed: () {
                      // context.go(AppRoutes.registrationScreen);
                    },
                    child: Text(
                      'Skip',
                      style: AppTextStyle.body16Regular.copyWith(
                        color: AppTheme.greyText,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Text(
                  "You Did It!",
                  style: AppTextStyle.title24MediumClash
                      .copyWith(color: AppTheme.primaryColorLight),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: AppTextStyle.body16Medium.copyWith(
                          color: AppTheme.blacktextColor(context),
                        ),
                        children: [
                          TextSpan(
                              text:
                                  "You've completed all levels and\nearned 200  "),
                          WidgetSpan(
                              child: SizedBox(
                                  height: 20,
                                  child:
                                      ShowImage(imagelink: AppAssets.skyCoin))),
                        ]),
                  ),
                ),
                Center(
                    child: SizedBox(
                        width: context.mediaQuery.size.width * 0.5,
                        child: ShowImage(imagelink: AppAssets.coinBoxClosed))),
                50.verticalSpace,
                Text(
                  "That’s real value for your data.",
                  style: AppTextStyle.body16Medium.copyWith(
                    color: AppTheme.blacktextColor(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: SubmitButton(
              onTap: () {
                // validate();
                context.go(
                  AppRoutes.dashboardScreen,
                );
              },
              labelsize: 13,
              isAtBottom: true,
              // tapable: ,
              color: Colors.transparent,
              labelColor: AppTheme.blacktextColor(context),
              label: "Go to Home",
            ),
          ),
          Expanded(
            child: SubmitButton(
              onTap: () {},
              labelsize: 13,
              isAtBottom: true,
              // tapable: ,
              label: "Earn More",
            ),
          ),
        ],
      ),
    );
  }
}

class SunburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = max(size.width, size.height);
    final rays = 50;
    final angle = 2 * pi / rays;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppTheme.greyText!.withOpacity(0.3); // Light blue

    for (int i = 0; i < rays; i++) {
      final path = Path();
      path.moveTo(center.dx, center.dy);
      final x1 = center.dx + radius * cos(i * angle);
      final y1 = center.dy + radius * sin(i * angle);
      final x2 = center.dx + radius * cos((i + 1) * angle);
      final y2 = center.dy + radius * sin((i + 1) * angle);
      path.lineTo(x1, y1);
      path.lineTo(x2, y2);
      path.close();

      // Draw only every other ray to get spacing
      if (i.isEven) {
        canvas.drawPath(path, paint);
      }
    }

    // Optional: draw central black circle
    canvas.drawCircle(
        center, radius * 0.1, Paint()..color = Colors.transparent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
