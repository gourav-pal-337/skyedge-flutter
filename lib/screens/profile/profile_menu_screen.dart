import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/extensions/int_extentions.dart';
import 'package:skyedge/widgets/my_appbar.dart';
import 'package:skyedge/widgets/show_image.dart';

class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({super.key});

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      title: 'My Wallet',
      darkIcon: AppAssets.myWalletIconD,
      lightIcon: AppAssets.myWalletIconL,
    ),
    MenuItemModel(
      title: 'My Data Sets',
      darkIcon: AppAssets.dataSetIconD,
      lightIcon: AppAssets.dataSetIconD,
    ),
    MenuItemModel(
      title: 'History',
      darkIcon: AppAssets.historyIconD,
      lightIcon: AppAssets.historyIconL,
      isExpandable: true,
      children: [
        MenuItemModel(
          title: 'Data Monetization',
          darkIcon: AppAssets.dataMonetizationD,
          lightIcon: AppAssets.dataMonetizationL,
        ),
        MenuItemModel(
          title: 'Transactions',
          darkIcon: AppAssets.transectionD,
          lightIcon: AppAssets.transectionD,
        ),
      ],
    ),
    MenuItemModel(
        title: 'Refer & Earn',
        darkIcon: AppAssets.referEarnD,
        lightIcon: AppAssets.referEarnL,
        screenRoute: AppRoutes.referAndEarnScreen),
    MenuItemModel(
      title: 'Notifications',
      darkIcon: AppAssets.referEarnD,
      lightIcon: AppAssets.referEarnL,
      screenRoute: AppRoutes.notificationScreen,
    ),
    MenuItemModel(
      title: 'Settings',
      darkIcon: AppAssets.settingD,
      lightIcon: AppAssets.settingL,
    ),
    MenuItemModel(
        title: 'Help & Support',
        darkIcon: AppAssets.helpSupportIconD,
        lightIcon: AppAssets.helpSupportIconD,
        screenRoute: AppRoutes.helpSupportScreen),
    MenuItemModel(
      title: 'Logout',
      darkIcon: AppAssets.logoutD,
      lightIcon: AppAssets.logoutL,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF111111),
      // appBar: MyAppBar(
      //   title: "",
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.verticalSpace,
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.myProfileScreen);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppTheme.blacktextColor(context),
                                width: 0.4),
                          ),
                          height: 75,
                          width: 75,
                          child: ShowImage(
                              imagelink:
                                  "https://media.licdn.com/dms/image/v2/D4D03AQGfmmtap9UGSw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1668447329811?e=2147483647&v=beta&t=0KlNkR86z7JOy1hLVPWrASGpK72NTRUy26PAxBsZ-QY")),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('F. David',
                              style: AppTextStyle.subtitle18SemiBold),
                          Row(
                            children: [
                              Text(
                                'Wallet ID: 123@xyz',
                                style: AppTextStyle.body14Medium.copyWith(
                                  color: AppTheme.greyText,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.copy,
                                  size: 16,
                                  color: AppTheme.blacktextColor(context)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Unverified',
                              style: AppTextStyle.caption12Regular
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: AppTheme.blacktextColor(context)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Divider(
              color: AppTheme.grey,
              thickness: 0.5,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: buildMenuList(context, AppTheme.isDarkMode(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuList(BuildContext context, bool isDarkTheme) {
    return Column(
      children: menuItems.map((item) {
        if (item.isExpandable) {
          return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            collapsedBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: ShowImage(
              height: 24,
              width: 24,
              imagelink: isDarkTheme ? item.darkIcon : item.lightIcon,
            ),
            // Icon(
            //   isDarkTheme ? item.darkIcon : item.lightIcon,
            //   color: Colors.white,
            // ),
            title: Text(
              item.title,
              style: AppTextStyle.body16Medium.copyWith(
                color: AppTheme.blacktextColor(context),
              ),
            ),
            iconColor: AppTheme.blacktextColor(context),
            collapsedIconColor: AppTheme.blacktextColor(context),
            children: item.children.map((subItem) {
              return _subMenuTile(
                context,
                isDarkTheme ? subItem.darkIcon : subItem.lightIcon,
                subItem.title,
              );
            }).toList(),
          );
        } else {
          return _menuTile(
            onTap: () async {
              debugPrint(item.screenRoute);
              if (item.title == "Logout") {
                await AuthProvider().signOut();
                context.go(AppRoutes.loginScreen);
              } else if (item.screenRoute != null) {
                context.push(item.screenRoute!);
              }
            },
            context,
            isDarkTheme ? item.darkIcon : item.lightIcon,
            item.title,
          );
        }
      }).toList(),
    );
  }

  Widget _menuTile(context, String icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ShowImage(
        height: 24,
        width: 24,
        imagelink: icon,
      ),
      // Icon(icon, color: Colors.white),
      title: Text(title,
          style: AppTextStyle.body16Medium
              .copyWith(color: AppTheme.blacktextColor(context))),
      trailing:
          Icon(Icons.chevron_right, color: AppTheme.blacktextColor(context)),
      onTap: onTap,
    );
  }

  Widget _subMenuTile(context, String icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 56),
      leading: ShowImage(
        height: 24,
        width: 24,
        imagelink: icon,
      ),
      title: Text(title,
          style: AppTextStyle.body16Medium
              .copyWith(color: AppTheme.blacktextColor(context))),
      onTap: () {},
    );
  }
}

class MenuItemModel {
  final String title;
  final String darkIcon;
  final String lightIcon;
  final String? screenRoute;

  final bool isExpandable;
  final List<MenuItemModel> children;

  MenuItemModel({
    required this.title,
    required this.darkIcon,
    required this.lightIcon,
    this.screenRoute,
    this.isExpandable = false,
    this.children = const [],
  });
}
