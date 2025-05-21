import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyedge/screens/feed/social_media_feed.dart';
import 'package:skyedge/screens/home/home_screen.dart';
import 'package:skyedge/screens/profile/profile_menu_screen.dart';
import 'package:skyedge/screens/wallet/wallet_screen.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/my_bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  // final String location;

  const DashboardScreen({
    super.key,
    this.child,
    // required this.location,
  });

  final Widget? child;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  List pages = [
    HomeScreen(),
    WalletScreen(),
    SizedBox(),
    SocialMediaFeedScreen(),
    ProfileMenuScreen(),
  ];

  void setPages() async {
    final prefs = await SharedPreferences.getInstance();
    bool? consultView = prefs.getBool('consultView');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // if (_currentIndex == 1)
          Container(
            padding: const EdgeInsets.only(bottom: 60),
            color: Colors.transparent,
            child: pages[_currentIndex],
          ),
          // if (_currentIndex != 1 && widget.child != null)
          // Container(
          //   padding: const EdgeInsets.only(bottom: 80),
          //   color: AppTheme.backgroundColorDark,
          //   child: SafeArea(child: widget.child!),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: MyBottomNavBar(
                onSelect: (item) {
                  if (item != 2) {
                    _currentIndex = item;
                  }
                  setState(() {});
                  // debugPrint("selected index: $item");
                  // debugPrint("current index: $_currentIndex");
                  // if (_currentIndex != 1) {
                  //   // _goOtherTab(
                  //   //   context,
                  //   //   _currentIndex > 1 ? _currentIndex - 1 : _currentIndex,
                  //   // );
                  // }
                  // context.go(AppRoutes.diary);
                },
                selectedIndex: _currentIndex,
              ),
            ),
          ),
        ],
      ),

      // bottomNavigationBar: Container(
      //   // alignment: Alignment.bottomCenter,
      //   height: 100,
      //   child: SafeArea(
      //     child: MyBottomNavBar(
      //       onSelect: (item) {
      //         _currentIndex = item;
      //         setState(() {});
      //       },
      //       selectedIndex: _currentIndex,
      //     ),
      //   ),
      // ),

      // BottomNavigationBar(
      //   selectedLabelStyle: AppTextStyle.textSmallSb,
      //   unselectedLabelStyle: AppTextStyle.textSmallSb,
      //   selectedItemColor: AppColors.primaryOrange,
      //   selectedFontSize: 12,
      //   unselectedItemColor: AppColors.grey3,
      //   showUnselectedLabels: true,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (int index) {
      //     _goOtherTab(context, index);
      //   },
      //   currentIndex: currentIndex(widget.location),
      //   items: [
      //     MyCustomBottomNavBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/home.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/home_active.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       label: LocaleKeys.home.tr(),
      //       initialLocation: AppRoutes.home,
      //     ),
      //     MyCustomBottomNavBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/therapies.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/therapies_active.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       label: LocaleKeys.therapies.tr(),
      //       initialLocation: AppRoutes.therapies,
      //     ),
      //     MyCustomBottomNavBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/learn.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/learn_active.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       label: LocaleKeys.learn.tr(),
      //       initialLocation: AppRoutes.learn,
      //     ),
      //     MyCustomBottomNavBarItem(
      //       icon: SvgPicture.asset(
      //         'assets/svg/diary.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       activeIcon: SvgPicture.asset(
      //         'assets/svg/diary_active.svg',
      //         width: 36.sp,
      //         height: 36.sp,
      //       ),
      //       label: LocaleKeys.diary.tr(),
      //       initialLocation: AppRoutes.diary,
      //     ),
      //   ],
      // ),
    );
  }

//   int currentIndex(String path) {
//     return widget.location.contains(AppRoutes.home)
//         ? 0
//         : widget.location.contains(AppRoutes.therapies)
//             ? 1
//             : widget.location.contains(AppRoutes.learn)
//                 ? 2
//                 : 3;
//   }

//   void _goOtherTab(BuildContext context, int index) {
//     // if (index == _currentIndex) return;
//     GoRouter router = GoRouter.of(context);
//     String location = [
//       MyCustomBottomNavBarItem(
//         icon: SvgPicture.asset(
//           'assets/svg/home.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         activeIcon: SvgPicture.asset(
//           'assets/svg/home_active.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         label: LocaleKeys.home.tr(),
//         initialLocation: AppRoutes.home,
//       ),
//       MyCustomBottomNavBarItem(
//         icon: SvgPicture.asset(
//           'assets/svg/therapies.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         activeIcon: SvgPicture.asset(
//           'assets/svg/therapies_active.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         label: "Consult",
//         initialLocation: AppRoutes.consultationWelcomeScreen,
//       ),
//       MyCustomBottomNavBarItem(
//         icon: SvgPicture.asset(
//           'assets/svg/learn.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         activeIcon: SvgPicture.asset(
//           'assets/svg/learn_active.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         label: LocaleKeys.learn.tr(),
//         initialLocation: AppRoutes.learn,
//       ),
//       MyCustomBottomNavBarItem(
//         icon: SvgPicture.asset(
//           'assets/svg/diary.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         activeIcon: SvgPicture.asset(
//           'assets/svg/diary_active.svg',
//           width: 36.sp,
//           height: 36.sp,
//         ),
//         label: LocaleKeys.diary.tr(),
//         initialLocation: AppRoutes.diary,
//       ),
//     ][index]
//         .initialLocation;

//     // setState(() {
//     //   _currentIndex = index;
//     // });

//     router.go(location);
//   }
// }

// class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
//   final String initialLocation;

//   const MyCustomBottomNavBarItem({
//     required this.initialLocation,
//     required super.icon,
//     super.label,
//     Widget? activeIcon,
//   }) : super(activeIcon: activeIcon ?? icon);
}
