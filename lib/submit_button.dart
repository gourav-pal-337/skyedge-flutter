import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    this.onLongTap,
    required this.label,
    this.loading = false,
    this.color = AppTheme.primaryColorLight,
    this.height = 53.0,
    this.width,
    this.labelsize = 17.0,
    this.tapable = true,
    this.isAtBottom = false,
    this.labelColor = Colors.black,
    this.borderColor = Colors.transparent,
    this.loaderColor = Colors.black,
    this.showShadow = false,
    this.borderRadius = 0,
    this.margin = 2,
    this.icon,
    this.iconAtFront = true,
    this.labelStyle,
    this.subtitle,
    this.padding,
  });

  final void Function() onTap;
  final void Function()? onLongTap;
  final String label;
  final bool loading;
  final Color color;
  final double height;
  final double? width;
  final bool showShadow;
  final double labelsize;
  final bool tapable;
  final bool isAtBottom;
  final Color labelColor;
  final Color borderColor;
  final Color loaderColor;
  final double borderRadius;
  final double margin;
  final Widget? subtitle;
  final Widget? icon;
  final bool iconAtFront;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool tapped = false;
  double margin = 0.0;
  @override
  Widget build(BuildContext context) {
    if (widget.isAtBottom) {
      setState(() {
        margin = 15;
      });
    } else {
      margin = widget.margin;
    }
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          bottom: margin,
          top: widget.isAtBottom ? 2 : margin,
          left: margin,
          right: margin,
        ),
        child: InkWell(
          onLongPress: widget.onLongTap,
          onHighlightChanged: (change) {
            setState(() {
              tapped = change;
            });
          },
          highlightColor: Colors.white,
          onTap: widget.loading == true
              ? null
              : widget.tapable == true
                  ? widget.onTap
                  : null,
          child: Container(
            height: widget.height,
            width: widget.width,
            alignment: Alignment.center,
            padding: tapped
                ? const EdgeInsets.symmetric(horizontal: 1, vertical: 1)
                : null,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(double.parse('${widget.borderRadius}')),
            ),
            child: Container(
              padding:
                  widget.padding ?? const EdgeInsets.symmetric(horizontal: 15),
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: widget.tapable
                    ? widget.color
                    : Colors.grey.withOpacity(0.3),
                border: Border.all(color: widget.borderColor),
                borderRadius: BorderRadius.circular(
                  double.parse('${widget.borderRadius}'),
                ),
                boxShadow: widget.showShadow
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 21,
                        )
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: widget.loading
                  ? Container(
                      height: double.parse('${widget.height}'),
                      width: double.parse('${widget.height}'),
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: widget.loaderColor,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.iconAtFront) widget.icon ?? Container(),
                        if (widget.iconAtFront && widget.icon != null)
                          const SizedBox(
                            width: 8,
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.label,
                              style: widget.labelStyle ??
                                  AppTextStyle.subtitle16SemiBold.copyWith(
                                    fontSize: widget.labelsize,
                                    color: widget.tapable
                                        ? widget.labelColor
                                        : Colors.white,
                                  ),
                              // TextStyle(
                              //   color: widget.tapable
                              //       ? widget.labelColor
                              //       : Colors.grey,
                              //   fontSize: double.parse('${widget.labelsize}'),
                              // ),
                            ),
                            widget.subtitle != null
                                ? const SizedBox(
                                    height: 6,
                                  )
                                : const SizedBox(),
                            widget.subtitle ?? const SizedBox()
                          ],
                        ),
                        if (!widget.iconAtFront && widget.icon != null)
                          const SizedBox(
                            width: 8,
                          ),
                        if (!widget.iconAtFront) widget.icon ?? Container(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// my dialog
