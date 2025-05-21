import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_text_form_field.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/show_image.dart';
import 'package:skyedge/widgets/submit_button.dart';

class SendTokenPopup extends StatefulWidget {
  const SendTokenPopup({super.key});

  @override
  State<SendTokenPopup> createState() => _SendTokenPopupState();
}

class _SendTokenPopupState extends State<SendTokenPopup> {
  TextEditingController textEditingController = TextEditingController();
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
          20.verticalSpace,
          Text("Send Tokens",
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle20Bold
                  .copyWith(color: AppTheme.greenTextColor(context))),
          10.verticalSpace,
          MyTextFormField(
              controller: textEditingController,
              label: "Available Balance: 65 SKT",
              hintText: "Enter Amount"),
          15.verticalSpace,
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [1, 2, 5, 10].map((value) {
              return GestureDetector(
                onTap: () {
                  textEditingController.text = "${value.toString()} SKT";
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.only(right: 11),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.greenTextColor(context)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "$value SKT",
                    style: AppTextStyle.button12,
                  ),
                ),
              );
            }).toList(),
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
