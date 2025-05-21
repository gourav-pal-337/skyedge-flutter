import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/utils/extensions/string_extensions.dart';
import 'package:skyedge/utils/router_util.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FirebaseNotificationHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Firebase Cloud Messaging
  Future<void> initializeFirebase() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming messages
      showNotification(message);
      debugPrint("Foreground message received: ${message.data}");
    });

    // App is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when app is opened from a background state
      _handleRedirect(message.data['route']);
      debugPrint("Message opened from background: ${message.data}");
    });

    _firebaseMessaging.subscribeToTopic('appContent');

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((String? newToken) async {
      debugPrint('Token refreshed: $newToken');
      // if(newToken!=null) {
      //   AppPreference().setFcmToken(newToken);
      //   await AuthRepo().updateFcmKey(newToken);
      // }
    });
  }

  //function to initialise flutter local notification plugin to show notifications
  void initLocalNotifications(BuildContext context) async {
    await _configureLocalTimeZone();
    if (Platform.isAndroid) {
      await AndroidFlutterLocalNotificationsPlugin()
          .requestExactAlarmsPermission();
    } else if (Platform.isIOS) {
      requestIOSPermissions();
    }
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        _handleRedirect(payload.payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    //app opened from terminated state
    checkTappedNotifaction();
  }

  void checkTappedNotifaction() async {
    FirebaseMessaging.instance.getInitialMessage().then((initialMessage) {
      // Handle when app is opened from a terminated state
      _handleRedirect(initialMessage?.data['route']);
      debugPrint("Message opened from background: ${initialMessage?.data}");
    });
    var tappedNotification = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (tappedNotification != null &&
        tappedNotification.notificationResponse != null) {
      notificationTapBackground(tappedNotification.notificationResponse!);
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    _handleRedirect(notificationResponse.payload);
    "Background clicked notification".toast();
  }

  // Delete token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      debugPrint('Token deleted successfully.');
    } catch (e) {
      debugPrint('Error deleting token: $e');
    }
  }

  // Background message handler
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // Handle background message
    await Firebase.initializeApp();
    debugPrint("Handling a background message: ${message.data}");
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  cancelAll() async => await _flutterLocalNotificationsPlugin.cancelAll();
  cancel(id) async => await _flutterLocalNotificationsPlugin.cancel(id);

  Future<String?> getToken() async {
    // Get the token initially (required for first time)
    String? initialToken = await _firebaseMessaging.getToken();
    debugPrint('Initial token: $initialToken');

    return initialToken;
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body,
      payload: message.data['route'].toString(),
      NotificationDetails(
        android: AndroidNotificationDetails(
          "channel_id",
          "channel_name",
          importance: Importance.max,
          priority: Priority.high,
          styleInformation:
              BigTextStyleInformation(message.notification!.body ?? ''),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
        ),
      ),
    );
  }

  Future<void> createNotification(
    String? title,
    String? body,
    String? payload,
  ) async {
    _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      payload: payload,
      NotificationDetails(
        android: AndroidNotificationDetails(
          "channel_id",
          "channel_name",
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body ?? ''),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
        ),
      ),
    );
  }

  /// Send notifications at 10 am and 6 pm daily
  Future<void> createScheduledNotification(
    String? title,
    String? body,
    String? payload,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      _nextInstanceOfTenAM(),
      NotificationDetails(
        android: AndroidNotificationDetails(
          "sch_channel_id",
          "sch_channel_name",
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body ?? ''),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      _nextInstanceOfSixPM(),
      NotificationDetails(
        android: AndroidNotificationDetails(
          "sch_channel_id",
          "sch_channel_name",
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body ?? ''),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  static Future<void> _handleRedirect(String? payload) async {
    if (payload != null && payload != "null") {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        // if (rootNavigatorKey.currentContext != null) {
        //   rootNavigatorKey.currentContext!.push(payload);
        // }
      });
    }
  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfSixPM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 21);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
