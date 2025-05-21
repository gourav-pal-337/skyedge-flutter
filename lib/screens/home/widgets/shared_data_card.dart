import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'dart:math';

import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/submit_button.dart';

class SharedDataCard extends StatelessWidget {
  const SharedDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "You've Shared This Much",
          style: AppTextStyle.body16Regular,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: CustomPaint(
                      painter: CircularProgressPainter(
                        percentage: 0.75,
                        color: AppTheme.primaryColorDark,
                      ),
                      child: const Center(
                        child: Text(
                          "753 MB",
                          style: AppTextStyle.body14Medium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Great!",
                          style: AppTextStyle.body14Medium
                              .copyWith(color: AppTheme.primaryColorDark),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "You have successfully uploaded X MB/GB of data so far.",
                          style: AppTextStyle.body14Medium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "updated on 7 Apr '25",
                          style: AppTextStyle.caption12Regular.copyWith(
                            color: AppTheme.greyText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SubmitButton(
                          onTap: () {
                            context.push(AppRoutes.dataConntributionScreen);
                          },
                          label: "View report",
                          color: Colors.transparent,
                          width: 100,
                          height: 36,
                          labelStyle: AppTextStyle.caption12Regular
                              .copyWith(color: AppTheme.primaryColorDark),
                          borderColor: AppTheme.primaryColorDark,
                        ),
                        // OutlinedButton(
                        //   onPressed: () {},
                        //   style: OutlinedButton.styleFrom(
                        //     foregroundColor: Colors.greenAccent,
                        //     side: const BorderSide(color: Colors.greenAccent),
                        //   ),
                        //   child: const Text("View report"),
                        // )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;

  CircularProgressPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;

    final basePaint = Paint()
      ..color = Colors.white12
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    canvas.drawCircle(center, radius, basePaint);

    // Progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = 2 * pi * percentage;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);

    // Dot at the end
    final dotAngle = -pi / 2 + sweepAngle;
    final dotOffset = Offset(
      center.dx + radius * cos(dotAngle),
      center.dy + radius * sin(dotAngle),
    );
    canvas.drawCircle(dotOffset, 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
