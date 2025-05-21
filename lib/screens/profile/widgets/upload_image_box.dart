import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class UploadImageBox extends StatelessWidget {
  final String? title;
  const UploadImageBox({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DashedContainer(
        color: AppTheme.greyText!,
        child: SizedBox(
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_upload_outlined,
                  color: AppTheme.blacktextColor(context), size: 28),
              SizedBox(height: 8),
              Text(title ?? "Upload front side",
                  style: AppTextStyle.caption12Medium
                      .copyWith(color: AppTheme.blacktextColor(context))),
              SizedBox(height: 4),
              Text(
                "JPG, PNG (max 5MB )",
                style: AppTextStyle.caption12Medium
                    .copyWith(color: AppTheme.greyText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final Color color;
  final BorderRadius borderRadius;

  const DashedContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.color = Colors.white24,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
        color: color,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final Color color;
  final BorderRadius borderRadius;

  _DashedBorderPainter({
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = borderRadius.toRRect(Offset.zero & size);
    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
