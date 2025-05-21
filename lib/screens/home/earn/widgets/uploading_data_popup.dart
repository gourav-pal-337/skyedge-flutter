import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/utils/progress_tracker.dart';

class UploadingDataPopup extends StatefulWidget {
  const UploadingDataPopup({super.key});

  @override
  State<UploadingDataPopup> createState() => _UploadingDataPopupState();
}

class _UploadingDataPopupState extends State<UploadingDataPopup> {
  int progress = 0;

  void startProgress() {
    final progresProv = Provider.of<ProgressTracker>(context, listen: false);
    progresProv.runWithProgress(
      () => Future.delayed(const Duration(seconds: 5)),
      key: ProgressKey.uploadingDataProgress,
      onDone: () {
        debugPrint('onDone() called');
        Navigator.pop(context, true);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  @override
  Widget build(BuildContext context) {
    final progresProv = Provider.of<ProgressTracker>(context);

    return Container(
      color: AppTheme.cardBackgroundColor(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Icon(Icons.close,
                      color: AppTheme.blacktextColor(context)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.verticalSpace,
                Text(
                  "Uploading your data...",
                  style: AppTextStyle.subtitle18Bold
                      .copyWith(color: AppTheme.primaryColorDark),
                ),
                10.verticalSpace,
                const Text(
                  "Hang tight while we securely process your data.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.caption12Regular,
                ),
                15.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progresProv.getProgressTracker(
                          ProgressKey.uploadingDataProgress,
                        ) /
                        100,
                    backgroundColor: AppTheme.grey,
                    minHeight: 10,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColorDark),
                  ),
                ),
                40.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
