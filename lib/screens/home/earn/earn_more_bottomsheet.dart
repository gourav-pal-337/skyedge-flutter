import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/home/earn/app_data_sync_sheet.dart';
import 'package:skyedge/screens/home/earn/data_categories_screen.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/build_context_extensions.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/expandable_page_view.dart';

class EarnMoreBottomsheet extends StatefulWidget {
  const EarnMoreBottomsheet({super.key});

  @override
  State<EarnMoreBottomsheet> createState() => _EarnMoreBottomsheetState();
}

class _EarnMoreBottomsheetState extends State<EarnMoreBottomsheet> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  // List pages = [
  //   const DataCategoryScreen(),
  //   Container(
  //     height: 200,
  //   )
  // ];
  void getAppData() {
    Future.delayed(Duration(seconds: 3), () {
      currentIndex = 2;
      pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // height: context.mediaQuery.size.height * 0.9,
        child: ExpandablePageView(
          pageController: pageController,
          children: [
            DataCategoryScreen(
              onNext: (data) {
                currentIndex = 1;
                pageController.animateToPage(currentIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
                setState(() {});
                getAppData();
              },
            ),
            LoadingSheet(),
            AppDataSyncScreen()
          ],
        ),
      ), // DataCategoryScreen(),
    );
  }
}

// Widget loadingWidget(context) {
//   return LoadingSheet();
// }

class LoadingSheet extends StatelessWidget {
  const LoadingSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mediaQuery.size.height * 0.6,
      decoration: BoxDecoration(
        color: AppTheme.cardBackgroundColor(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          15.verticalSpace,
          Text('Finding relevant apps...',
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle20Bold.copyWith(
                color:
                    // Color(0xFFA8FC99)
                    AppTheme.primaryColorDark,
              )),
          10.verticalSpace,
          const Text(
              'We’re scanning your phone for apps that match your selected category. Hang tight, this won’t take long! .',
              textAlign: TextAlign.center,
              style: AppTextStyle.caption12Regular),
          20.verticalSpace,
          Expanded(
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: AppTheme.primaryColorDark,
                size: 70,
              ),
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
