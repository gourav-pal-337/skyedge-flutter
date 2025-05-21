import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/providers/theme_provider.dart';
import 'package:skyedge/service/local_storage.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/show_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToNext(BuildContext context) async {
    // Store context in a variable to avoid using it after async operations
    final navigatorContext = context;
    // MyLocalStorage.clearAll();

    try {
      // Wait for the delay
      await Future.delayed(const Duration(seconds: 3));

      // Get auth token
      final authToken = await MyLocalStorage.getToken();
      log("authtoken : $authToken");

      if (authToken != null && authToken.isNotEmpty) {
        // Fetch user data
        final authProvider =
            Provider.of<AuthProvider>(navigatorContext, listen: false);
        final userDataFetched = await authProvider.fetchUserData();

        if (navigatorContext.mounted) {
          if (userDataFetched) {
            navigatorContext.go(AppRoutes.questionnaireWelcomeScreen);
          } else {
            // If user data fetch fails, redirect to login
            navigatorContext.go(AppRoutes.loginScreen);
          }
        }
      } else {
        // Handle case when token is empty
        navigatorContext.go(AppRoutes.loginScreen);
      }
    } catch (e) {
      debugPrint("Error during navigation: $e");
      // Handle any errors that might occur during the process
      if (navigatorContext.mounted) {
        navigatorContext.go(AppRoutes.onboardingScreen);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigateToNext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    debugPrint("theme data : ${themeProvider.isDarkMode}");
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1D1E22), // Very dark gray/almost black at the top
                  Color(0xFF1D1E22), // Same dark color for most of the screen
                  Color(0xFF1D1E22), // Same dark color
                  Color(
                      0xFF1D2533), // Slightly blue-tinted dark color at the bottom
                ],
                stops: [0.0, 0.6, 0.8, 1.0], // Distribution of colors
              ),
            ),
            alignment: Alignment.center,
            child: const SizedBox(
              height: 180,
              child: ShowImage(
                imagelink: AppAssets.logo,
              ),
            ),
          ),
          Positioned(
            bottom: -size.width * 0.2,
            right: -size.width * 0.2,
            child: Container(
              height: size.width * 0.7,
              width: size.width * 0.9,
              // transform: Matrix4.translationValues(
              //   10,
              //   20,
              //   0,
              // ), // move
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: AppTheme.blue.withOpacity(0.3),
                    blurRadius: 200,
                    offset: const Offset(0, 0),
                    spreadRadius: 50)
              ]),
            ),
          )
        ],
      ),
    );
  }
}
