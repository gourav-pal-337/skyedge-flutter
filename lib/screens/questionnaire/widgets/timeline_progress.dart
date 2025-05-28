import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class TimelineProgress extends StatefulWidget {
  final List<String> steps;
  final int currentStep;
  final double? fraction;

  const TimelineProgress({
    Key? key,
    required this.steps,
    required this.currentStep,
    this.fraction = 0.0,
  }) : super(key: key);

  @override
  State<TimelineProgress> createState() => _TimelineProgressState();
}

class _TimelineProgressState extends State<TimelineProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(TimelineProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep ||
        oldWidget.fraction != widget.fraction) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = AppTheme.blue;
    final inactiveColor = isDark ? Colors.white : AppTheme.grey;

    // Build the list of widgets alternating nodes/labels and lines
    final List<Widget> timelineChildren = [];

    for (int i = 0; i < widget.steps.length; i++) {
      final stepIndex = i;
      final isActive = stepIndex == widget.currentStep;
      final isCompleted = stepIndex < widget.currentStep;

      // Add Node and Label Column
      timelineChildren.add(
        Expanded(
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isActive ? 1 + (_progressAnimation.value * 0.1) : 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        color: isActive
                            ? activeColor.withOpacity(0.2)
                            : inactiveColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive || isCompleted
                              ? activeColor
                              : inactiveColor!,
                          width: 2,
                        ),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: activeColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                )
                              ]
                            : null,
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.done,
                              color: AppTheme.blue,
                              size: 10,
                            )
                          : Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: isActive ? 8 : 4,
                                width: isActive ? 8 : 4,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? activeColor
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 80,
                      child: Text(
                        widget.steps[stepIndex],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: AppTextStyle.button10.copyWith(
                            color: isActive ? activeColor : AppTheme.greyText,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 9),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Add Line segment between nodes (except after the last node)
      if (i < widget.steps.length - 1) {
        final lineIndex = i;
        timelineChildren.add(
          Expanded(
            flex: 2, // Give lines more flexibility
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0), // Align line with the middle of the node circle
              child: Stack(
                children: [
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: lineIndex < widget.currentStep
                          ? activeColor
                          : inactiveColor,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  if (lineIndex == widget.currentStep)
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          widthFactor:
                              widget.fraction! * _progressAnimation.value,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: activeColor,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: timelineChildren,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
