import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/show_image.dart';

class SkyeTokenCard extends StatelessWidget {
  const SkyeTokenCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        border: const Border(
            bottom: BorderSide(color: AppTheme.primaryColorLight, width: 0.5)),
      ),
      child: CustomPaint(
        painter:
            TopographicTexturePainter(isDarkMode: AppTheme.isDarkMode(context)),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Label
              Row(
                children: [
                  Text('SKYEDGE Tokens', style: AppTextStyle.body14Regular),
                  const SizedBox(width: 6),
                  ShowImage(
                      imagelink: AppAssets.skyCoin, width: 20, height: 20),
                ],
              ),

              const SizedBox(height: 16),

              /// Token Value
              const Text('4,378.44 SKYE',
                  style: AppTextStyle.title32BoldCllash),

              const SizedBox(height: 12),

              /// USD Value
              Text(
                '= \$1299 USD',
                style: AppTextStyle.body14Medium.copyWith(
                    // fontSize: 16,
                    color: AppTheme.blacktextColor(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopographicTexturePainter extends CustomPainter {
  final bool isDarkMode;
  final Color? textureColor;
  const TopographicTexturePainter({
    this.isDarkMode = false,
    this.textureColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Color bgColor = textureColor ?? (isDarkMode ? Colors.white : Colors.black);
    final paint = Paint()
      ..color = bgColor.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const spacing = 12.0;

    for (double x = 0; x < size.width; x += spacing) {
      final path = Path();
      path.moveTo(x, 0);
      for (double y = 0; y <= size.height; y += 8) {
        final dx = 6 * sin((y / 40) + (x / 30));
        path.lineTo(x + dx, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
