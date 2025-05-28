import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/screens/authentication/login_screen.dart';
import 'package:skyedge/screens/authentication/otp_verification_screenn.dart';
import 'package:skyedge/screens/authentication/registration_screen.dart';
import 'package:skyedge/screens/dashboard_screen.dart';
import 'package:skyedge/screens/data/bank_statement_scree.dart';
import 'package:skyedge/screens/data/data_sets_category.dart';
import 'package:skyedge/screens/data/data_sets_sub_cat.dart';
import 'package:skyedge/screens/feed/social_media_feed.dart';
import 'package:skyedge/screens/feed/user_profile_scree.dart';
import 'package:skyedge/screens/home/data_contribution_screen.dart';
import 'package:skyedge/screens/home/earn/data_intelligence_screen.dart';
import 'package:skyedge/screens/home/earn/refer_and_earn_screen.dart';
import 'package:skyedge/screens/home/earn/widgets/data_uploaded_scree.dart';
import 'package:skyedge/screens/home/home_screen.dart';
import 'package:skyedge/screens/onboarding/onboarding_screen.dart';
import 'package:skyedge/screens/profile/my_profile_screen.dart';
import 'package:skyedge/screens/profile/profile_menu_screen.dart';
import 'package:skyedge/screens/profile/verification_screen.dart';
import 'package:skyedge/screens/questionnaire/completion_screen.dart';
import 'package:skyedge/screens/questionnaire/questionnaire_screen.dart';
import 'package:skyedge/screens/questionnaire/welcome_screen.dart';
import 'package:skyedge/screens/splash/splash_screen.dart';
import 'package:skyedge/screens/support/faq_screen.dart';
import 'package:skyedge/screens/support/help_support_screen.dart';
import 'package:skyedge/screens/support/notificarion_scree.dart';
import 'package:skyedge/screens/support/privacy_policies.dart';
import 'package:skyedge/screens/support/terms_condition.dart';
import 'package:skyedge/screens/wallet/buy/buy_screen.dart';
import 'package:skyedge/screens/wallet/conect_wallet.dart';
import 'package:skyedge/screens/wallet/data_monetization_details.dart';
import 'package:skyedge/screens/wallet/new_wallet_history_screen.dart';
import 'package:skyedge/screens/wallet/order_history_screen.dart';
import 'package:skyedge/screens/wallet/sell/completion_screen.dart';
import 'package:skyedge/screens/wallet/sell/preview_scree.dart';
import 'package:skyedge/screens/wallet/sell/sell_screen.dart';
import 'package:skyedge/screens/wallet/transection_details_screen.dart';
import 'package:skyedge/screens/wallet/transfer/conversion_screen.dart';
import 'package:skyedge/screens/wallet/transfer/transfer_completion.dart';
import 'package:skyedge/screens/wallet/transfer/transfer_screen.dart';
import 'package:skyedge/screens/wallet/verify_wallet_screen.dart';
import 'package:skyedge/screens/wallet/wallet_history_screen.dart';
import 'package:skyedge/screens/wallet/wallet_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class RouterUtil {
  // static final GlobalKey<ScaffoldState> dashboardScaffold =
  //     GlobalKey<ScaffoldState>();
  static final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    observers: [
      RouterNavigatorObserver(),
    ],
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingScreen,
        name: AppRoutes.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.registrationScreen,
        name: AppRoutes.registrationScreen,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerificationScreen,
        name: AppRoutes.otpVerificationScreen,
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.questionnaireWelcomeScreen,
        name: AppRoutes.questionnaireWelcomeScreen,
        builder: (context, state) => const QuestionnaireWelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.questionnaireScreen,
        name: AppRoutes.questionnaireScreen,
        builder: (context, state) => const QuestionnaireScreen(),
      ),
      GoRoute(
        path: AppRoutes.questionnaireCompletionScreen,
        name: AppRoutes.questionnaireCompletionScreen,
        builder: (context, state) => const QuestionnaireCompletionScreen(),
      ),
      ShellRoute(
        // path: AppRoutes.dashboardScreen,
        // name: AppRoutes.dashboardScreen,
        navigatorKey: _shellNavigatorKey,
        // parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, child) => DashboardScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.newWalletHistoryScreen,
            name: AppRoutes.newWalletHistoryScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              child: const NewWalletHistoryScreen(),
            ),
            // builder: (context, state) => const NewWalletHistoryScreen(),
          ),
          GoRoute(
            path: AppRoutes.dashboardScreen,
            name: AppRoutes.dashboardScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              child: const HomeScreen(),
            ),
            // builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.walletScreen,
            name: AppRoutes.walletScreen,
            // parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) => NoTransitionPage(
              child: const WalletScreen(),
            ),
            // builder: (context, state) => const WalletScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.walletHistoryScreen,
        name: AppRoutes.walletHistoryScreen,
        // parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const WalletHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileMenuScreen,
        name: AppRoutes.profileMenuScreen,
        builder: (context, state) => const ProfileMenuScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataUploadedScreen,
        name: AppRoutes.dataUploadedScreen,
        builder: (context, state) => DataUploadedScreen(),
      ),

      // GoRoute(
      //   path: AppRoutes.newWalletHistoryScreen,
      //   name: AppRoutes.newWalletHistoryScreen,
      //   builder: (context, state) => const NewWalletHistoryScreen(),
      // ),
      GoRoute(
        path: AppRoutes.dataIntelligenceScreen,
        name: AppRoutes.dataIntelligenceScreen,
        builder: (context, state) => DataIntelligenceScreen(),
      ),
      GoRoute(
        path: AppRoutes.referAndEarnScreen,
        name: AppRoutes.referAndEarnScreen,
        builder: (context, state) => ReferAndEarnScreen(),
      ),
      GoRoute(
        path: AppRoutes.myProfileScreen,
        name: AppRoutes.myProfileScreen,
        builder: (context, state) => MyProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.verificationScreen,
        name: AppRoutes.verificationScreen,
        builder: (context, state) => VerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataMonetizationDetailsScreen,
        name: AppRoutes.dataMonetizationDetailsScreen,
        builder: (context, state) => DataMonetizationDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.trasactionDetailsScreen,
        name: AppRoutes.trasactionDetailsScreen,
        builder: (context, state) => TransactionDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.orderHistorysScreen,
        name: AppRoutes.orderHistorysScreen,
        builder: (context, state) => OrderHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.buyScreen,
        name: AppRoutes.buyScreen,
        builder: (context, state) => const BuyScreen(),
      ),
      GoRoute(
        path: AppRoutes.sellScreen,
        name: AppRoutes.sellScreen,
        builder: (context, state) => const SellScreen(),
      ),
      GoRoute(
        path: AppRoutes.previewOrderScreen,
        name: AppRoutes.previewOrderScreen,
        builder: (context, state) => const PreviewOrderScreen(),
      ),
      GoRoute(
        path: AppRoutes.orderCompletionScreen,
        name: AppRoutes.orderCompletionScreen,
        builder: (context, state) => const OrderCompletionScreen(),
      ),
      GoRoute(
        path: AppRoutes.connectWalletScreen,
        name: AppRoutes.connectWalletScreen,
        builder: (context, state) => const ConnectWalletScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyWalletScreen,
        name: AppRoutes.verifyWalletScreen,
        builder: (context, state) => const VerifyWalletScreen(),
      ),
      GoRoute(
        path: AppRoutes.socialMediaFeedScreen,
        name: AppRoutes.socialMediaFeedScreen,
        builder: (context, state) => SocialMediaFeedScreen(),
      ),
      GoRoute(
        path: AppRoutes.userProfileScreen,
        name: AppRoutes.userProfileScreen,
        builder: (context, state) => UserProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.helpSupportScreen,
        name: AppRoutes.helpSupportScreen,
        builder: (context, state) => HelpSupportScreen(),
      ),
      GoRoute(
        path: AppRoutes.faqScreen,
        name: AppRoutes.faqScreen,
        builder: (context, state) => FAQScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacyPoliciesScreen,
        name: AppRoutes.privacyPoliciesScreen,
        builder: (context, state) => PrivacyPolicies(),
      ),
      GoRoute(
        path: AppRoutes.termConditionScreen,
        name: AppRoutes.termConditionScreen,
        builder: (context, state) => TermsConditionScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationScreen,
        name: AppRoutes.notificationScreen,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.transeferScreen,
        name: AppRoutes.transeferScreen,
        builder: (context, state) => TransferScreen(),
      ),
      GoRoute(
        path: AppRoutes.tranferCompletionScreen,
        name: AppRoutes.tranferCompletionScreen,
        builder: (context, state) => TransferCompletionScreen(),
      ),
      GoRoute(
        path: AppRoutes.conversionScreen,
        name: AppRoutes.conversionScreen,
        builder: (context, state) => ConnversionScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataSetCategoryScreen,
        name: AppRoutes.dataSetCategoryScreen,
        builder: (context, state) => DataSetsCategoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataSetSubCategoryScreen,
        name: AppRoutes.dataSetSubCategoryScreen,
        builder: (context, state) => DataSetsSubCategoryScreenn(),
      ),
      GoRoute(
        path: AppRoutes.bankStatementScreen,
        name: AppRoutes.bankStatementScreen,
        builder: (context, state) => BankStatementsScreen(),
      ),
      GoRoute(
        path: AppRoutes.dataConntributionScreen,
        name: AppRoutes.dataConntributionScreen,
        builder: (context, state) => DataContributionScreen(),
      ),
    ],
  );
}

class RouterNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Route popped: ${route.settings.name}');
    log('Returning to: ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('Route removed: ${route.settings.name}');
    log('Previous route: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('Route replaced: ${newRoute?.settings.name}');
    log('Old route: ${oldRoute?.settings.name}');
  }
}
