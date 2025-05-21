import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/theme/app_theme.dart';
// import 'package:path_rational/constants/app_assets.dart';
// import 'package:path_rational/constants/app_colors.dart';
// import 'package:path_rational/constants/app_gradients.dart';
// import 'package:path_rational/constants/app_styles.dart';
// import 'package:path_rational/utils/extensions/build_context_extensions.dart';
// import 'package:path_rational/utils/extensions/int_extentions.dart';
// import 'package:path_rational/widgets/show_image.dart';

class MyBottomNavBar extends StatefulWidget {
  final void Function(int selectedValue) onSelect;
  final int selectedIndex;
  const MyBottomNavBar({
    required this.onSelect,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  List navBarItems = [
    {
      "icon": AppAssets.dashboardIcon,
      "route": AppRoutes.dashboardScreen,
      "label": "Dashboard",
    },
    {
      "icon": AppAssets.walletIcon,
      "route": AppRoutes.walletScreen,
      "label": "Wallet",
    },
    {
      "icon": AppAssets.uploadCloudIcon,
      // "route": AppRoutes.dashboardScreen,

      // "activeIcon": AppAssets.gutPlusIcon,
      "label": "",
    },
    {
      "icon": AppAssets.feedIcon,
      "route": AppRoutes.dashboardScreen,

      // "activeIcon": AppAssets.learnActiveIcon,
      "label": "Feed",
    },
    {
      "icon": AppAssets.profileIcon,
      "route": AppRoutes.dashboardScreen,

      // "activeIcon": AppAssets.dairyActiveIcon,
      "label": "Profile",
    },
  ];
  @override
  Widget build(BuildContext context) {
    double bottomBarSize = 10;

    // MediaQuery.of(context).padding.bottom;
    // debugPrint('bottom bar sixe : $bottomBarSize');
    return SafeArea(
      child: Container(
        // height: ,
        // color: Colors.red,
        height: 120 + bottomBarSize,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  height: 98 + bottomBarSize,
                  margin: const EdgeInsets.only(
                    top: 40,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    color: AppTheme.cardBackgroundColor(context),
                  ),
                ),
                Container(
                  height: 98 + bottomBarSize,
                  padding: EdgeInsets.only(
                      left: 15, right: 15, bottom: bottomBarSize),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: navBarItems.map((item) {
                      int index = navBarItems
                          .indexWhere((elem) => elem['icon'] == item['icon']);
                      bool isSelected = widget.selectedIndex == index;
                      if (index == 2) {
                        return GestureDetector(
                          onTap: () {
                            // widget.onSelect(index);
                            // context.push(AppRoutes.gutProScreen);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            // width: 75,
                            padding: const EdgeInsets.all(5),
                            // height: 75,
                            decoration: BoxDecoration(
                              color: AppTheme.cardBackgroundColor(context),
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppTheme.primaryColorDark
                                            .withOpacity(0.8),
                                        AppTheme.blue,
                                      ],
                                    ),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: AppTheme.blue.withOpacity(0.4),
                                    //     blurRadius: 20,
                                    //     spreadRadius: 2,
                                    //     offset: const Offset(0, 10),
                                    //   ),
                                    // ],
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: SvgPicture.asset(item['icon'],
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          widget.onSelect(index);
                          context.go(item['route']);
                        },
                        child: Container(
                          width: 65,
                          // height: isSelected ? 71 : 25,
                          // padding: EdgeInsets.only(top: 20),
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SvgPicture.asset(
                                    item['icon'],
                                    color: isSelected
                                        ? AppTheme.blue
                                        : AppTheme.greyText,
                                  ),
                                ),
                              ),
                              Text(
                                item['label'],
                                style: AppTextStyle.caption12Small.copyWith(
                                  color: isSelected
                                      ? AppTheme.blue
                                      : AppTheme.greyText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
