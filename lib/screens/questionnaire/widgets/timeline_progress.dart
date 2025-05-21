import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class TimelineProgress extends StatefulWidget {
  List<String> steps;
  final int currentStep;
  final double? fraction;

  TimelineProgress({
    Key? key,
    required this.steps,
    required this.currentStep,
    this.fraction = 0.0,
  }) : super(key: key);

  @override
  State<TimelineProgress> createState() => _TimelineProgressState();
}

class _TimelineProgressState extends State<TimelineProgress> {
  //27.0.12077973
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = AppTheme.blue;
    final inactiveColor = isDark ? Colors.white : AppTheme.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate((widget.steps.length) * 2 - 1, (index) {
                  if (index.isOdd) {
                    // Line between dots
                    debugPrint(
                        " index ${index.toString()}  : ${widget.currentStep} : ${(widget.currentStep * 2) + 1}");
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          Container(
                            height: 2,
                            color: index ~/ 2 < widget.currentStep
                                ? activeColor
                                : inactiveColor,
                          ),
                          if (index == (widget.currentStep * 2) + 1) ...[
                            FractionallySizedBox(
                              // height: 2,
                              widthFactor: widget.fraction,
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  height: 2,
                                  color: activeColor),
                            ),
                          ]
                        ],
                      ),
                    )
                        //  Divider(
                        //   color: index ~/ 2 < currentStep ? activeColor : inactiveColor,
                        //   thickness: 2,
                        // ),
                        );
                  } else {
                    final stepIndex = index ~/ 2;
                    final isActive = stepIndex == widget.currentStep;
                    final isCompleted = stepIndex < widget.currentStep;

                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
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
                              ),
                              child: isCompleted
                                  ? Icon(
                                      Icons.done,
                                      color: AppTheme.blue,
                                      size: 10,
                                    )
                                  : Center(
                                      child: Container(
                                        height: 4,
                                        width: 4,
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? activeColor
                                              : Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   child: Text(
                        //     steps[stepIndex],
                        //     style: AppTextStyle.button10.copyWith(
                        //       fontSize: 12,
                        //       color: isActive ? activeColor : AppTheme.greyText,
                        //       fontWeight:
                        //           isActive ? FontWeight.w600 : FontWeight.w400,
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  }
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.steps.length * 2 - 1, (index) {
                if (index.isOdd) {
                  // Line between dots

                  return Expanded(child: SizedBox());
                } else {
                  final stepIndex = index ~/ 2;
                  final isActive = stepIndex == widget.currentStep;
                  // final isCompleted = stepIndex < currentStep;

                  return Column(
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        widget.steps[stepIndex],
                        style: AppTextStyle.button10.copyWith(
                          // fontSize: 12,
                          color: isActive ? activeColor : AppTheme.greyText,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
