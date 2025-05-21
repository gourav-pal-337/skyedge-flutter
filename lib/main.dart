import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/firebase_options.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/utils/app_providers.dart';
import 'package:skyedge/utils/router_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true,
  );

  // await SentryUtil().init(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (_) => MultiProvider(
        providers: appProviders,
        child: MaterialApp.router(
          // ignore: avoid_redundant_argument_values
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          routerConfig: RouterUtil.router,
        ),
      ),
    );
  }
}
