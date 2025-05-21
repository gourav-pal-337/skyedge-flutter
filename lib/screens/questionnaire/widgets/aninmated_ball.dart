import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skyedge/constants/app_assets.dart';

class AnimatedBall extends StatefulWidget {
  const AnimatedBall({super.key});

  @override
  State<AnimatedBall> createState() => _AnimatedBallState();
}

class _AnimatedBallState extends State<AnimatedBall>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _twinkleController;
  late AnimationController _twinkleController2;
  late AnimationController _twinkleController3;

  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _twinkleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _twinkleController2 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _twinkleController3 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    Future.delayed(const Duration(milliseconds: 1200), () {
      _twinkleController2
        ..forward()
        ..repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 1200 * 2), () {
      _twinkleController3
        ..forward()
        ..repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _twinkleController.dispose();
    _twinkleController2.dispose();
    _twinkleController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 250;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating glow ball with radial gradient
          RotationTransition(
            turns: _rotationController,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    // center: Alignment.center,
                    // radius: 0.9,
                    colors: [
                      Color(0xFF40C4FF).withOpacity(0.6), // cyan/blue center
                      Color(0xFF2962FF), // deep blue outer
                      // Color(0xFF40C4FF), // cyan/blue center
                    ],
                    stops: [0.2, 0.95],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF40C4FF).withOpacity(0.6),
                      blurRadius: 60,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: Stack(
              children: [
                SizedBox(
                  height: size / 2.5,
                  width: size / 2.5,
                ),

                Positioned(
                  bottom: 20,
                  left: 10,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.2)
                        .animate(_twinkleController),
                    child: FadeTransition(
                        opacity: _twinkleController, child: starWidget()),
                  ),
                ),
                Positioned(
                  left: 35,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.2)
                        .animate(_twinkleController2),
                    child: FadeTransition(
                        opacity: _twinkleController, child: starWidget()),
                  ),
                ),
                // Center(
                //   child: FadeTransition(
                //     opacity: _twinkleController,
                //     child: const Icon(
                //       Icons.star,
                //       color: Color(0xFFDAFF70),
                //       size: 36,
                //     ),
                //   ),
                // ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.2)
                        .animate(_twinkleController3),
                    child: FadeTransition(
                        opacity: _twinkleController, child: starWidget()),
                  ),
                ),
              ],
            ),
          ),

          // Twinkling stars
        ],
      ),
    );
  }
}

Widget starWidget() {
  return SvgPicture.asset(
    AppAssets.blinkStar,
  );
}
