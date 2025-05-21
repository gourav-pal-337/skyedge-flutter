import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/providers/theme_provider.dart';
import 'package:skyedge/theme/app_theme.dart';

enum Style {
  bgFillWhiteA700,
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Style? styleType;
  final VoidCallback? onBackPressed;
  final bool centerTitle;

  const MyAppBar({
    Key? key,
    this.title,
    this.styleType,
    this.onBackPressed,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    // Color backgroundColor = themeProvider.isDarkMode
    //     ? AppTheme.backgroundColorDark
    //     : AppTheme.backgroundColorLight;
    Color foregroundColor = AppTheme.isDarkMode(context)
        ? AppTheme.foregroundColorDark
        : AppTheme.foregroundColorLight;

    return AppBar(
      // backgroundColor: _getBackgroundColor(context),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      centerTitle: centerTitle,
      title: Text(
        title ?? "",
        style: AppTextStyle.title24MediumClash,
      ),
      leading: !context.canPop()
          ? null
          : GestureDetector(
              onTap: onBackPressed ?? () => Navigator.of(context).pop(),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: foregroundColor.withOpacity(0.2),
                  ),
                  child: Icon(
                    CupertinoIcons.chevron_back,
                    color: foregroundColor,
                    size: 20,
                  ),
                ),
              ),
            ),
    );
  }

  // Color? _getBackgroundColor(BuildContext context) {
  //   switch (styleType) {
  //     case Style.bgFillWhiteA700:
  //       return Colors.white; // or AppTheme.white if defined
  //     default:
  //       return Theme.of(context).appBarTheme.backgroundColor;
  //   }
  // }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
