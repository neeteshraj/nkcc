import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission();
    }

    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);

    _firebaseMessaging.getInitialMessage().then(_onInitialMessage);

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_notification');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _onMessageReceived(RemoteMessage message) async {
    print('Received a foreground message: ${message.notification?.title}');

    await showNotification(message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body');
  }

  void _onMessageOpened(RemoteMessage message) {
    print('App opened by a notification: ${message.notification?.title}');
  }

  void _onInitialMessage(RemoteMessage? message) {
    if (message != null) {
      print('App opened by notification on launch: ${message.notification?.title}');
    }
  }

  Future<void> showNotification(String title, String body) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'default_channel_id',
        'default_channel_name',
        channelDescription: 'Default channel description',
        importance: Importance.max,
        priority: Priority.high,
        icon: "ic_notification",
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
