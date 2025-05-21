import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class TokenizeActionPopup extends StatelessWidget {
  final String? title;
  final String? description;
  final int? points;
  final String? confirmText;
  final String? goBackText;
  final String? pointsText;
  final TextStyle? titleStyle;

  const TokenizeActionPopup(
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
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child:
                    Icon(Icons.close, color: AppTheme.blacktextColor(context)),
              ),
            ),
          ),
          ShowImage(
            width: 97,
            imagelink: AppAssets.iconStar,
            boxFit: BoxFit.contain,
          ),
          20.verticalSpace,
          Text("Tokenize Every Action!",
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle20Bold
                  .copyWith(color: AppTheme.greenTextColor(context))),
          10.verticalSpace,
          Text(
            "Your interactions = SKT earnings.",
            textAlign: TextAlign.center,
            style: AppTextStyle.caption12Regular,
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 15,
              ),
              10.horizontalSpace,
              Text(
                "Like → +1 SKT",
                textAlign: TextAlign.center,
                style: AppTextStyle.caption12Regular,
              ),
            ],
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.commentIcon,
                  height: 15,
                  width: 15,
                  color: AppTheme.blacktextColor(context)),
              10.horizontalSpace,
              Text(
                "Comment → +2 SKT",
                textAlign: TextAlign.center,
                style: AppTextStyle.caption12Regular,
              ),
            ],
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.shareIcon,
                  height: 15,
                  width: 15,
                  color: AppTheme.blacktextColor(context)),
              10.horizontalSpace,
              Text(
                "Share → +5 SKT",
                textAlign: TextAlign.center,
                style: AppTextStyle.caption12Regular,
              ),
            ],
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowImage(
                imagelink: AppAssets.skyCoin,
                height: 15,
                width: 15,
              ),
              10.horizontalSpace,
              Text(
                "Transfer → Send any SKT to others",
                textAlign: TextAlign.center,
                style: AppTextStyle.caption12Regular,
              ),
            ],
          ),
          15.verticalSpace,
          SubmitButton(
            onTap: () {
              Navigator.pop(context);
            },
            label: "Continue",
            labelsize: 12,
            height: 36,
          ),
          20.verticalSpace
        ],
      ),
    );
  }
}
