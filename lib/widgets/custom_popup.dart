import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

Future showMyCustomPopup(context,
    {String? title,
    String? description,
    int? points,
    String? confirmText,
    String? pointsText,
    TextStyle? titleStyle,
    String? goBackText}) {
  return showDialog(
      context: context,
      builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: MyCustomPopup(
            title: title,
            description: description,
            confirmText: confirmText,
            goBackText: goBackText,
            titleStyle: titleStyle,
            pointsText: pointsText,
            points: 2,
          )));
}

class MyCustomPopup extends StatelessWidget {
  final String? title;
  final String? description;
  final int? points;
  final String? confirmText;
  final String? goBackText;
  final String? pointsText;
  final TextStyle? titleStyle;

  const MyCustomPopup(
      {this.title = "Title",
      this.description = "Description",
      this.points = 0,
      this.confirmText = "Confirm",
      this.goBackText = "Go Back",
      this.pointsText,
      this.titleStyle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      color: AppTheme.cardBackgroundColor(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child:
                    Icon(Icons.close, color: AppTheme.blacktextColor(context)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: pointsText == null ? 20 : 30, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.grey?.withOpacity(0.1),
                border: Border.all(color: AppTheme.blacktextColor(context)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text(
                    "Available Balance",
                    style: AppTextStyle.caption12Regular
                        .copyWith(color: AppTheme.greyText),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: ShowImage(
                          imagelink: AppAssets.skyCoin,
                        ),
                      ),
                      5.horizontalSpace,
                      Text(
                        "$points points",
                        style: AppTextStyle.caption12Regular
                            .copyWith(color: AppTheme.blue),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
          Text(title ?? '',
              textAlign: TextAlign.center,
              style: titleStyle ?? AppTextStyle.title24Medium),
          10.verticalSpace,
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: AppTextStyle.caption12Regular,
          ),
          15.verticalSpace,
          if (confirmText != "null")
            SubmitButton(
              onTap: () {
                context.pop(true);
              },
              label: confirmText ?? "Confirm",
              labelsize: 12,
              height: 36,
            ),
          10.verticalSpace,
          if (goBackText != "null")
            SubmitButton(
              onTap: () {
                context.pop(false);
              },
              label: goBackText ?? "Go Back",
              labelsize: 12,
              labelColor: AppTheme.primaryColorLight,
              color: Colors.transparent,
              height: 36,
            ),
        ],
      ),
    );
  }
}
