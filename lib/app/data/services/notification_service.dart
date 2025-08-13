import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse details) {
  NotificationService.instance.pendingPayload = details.payload;
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotification();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  String? pendingPayload;

  static const String _channelId = 'channel_my_wng';

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await setupFlutterNotification();
    await _requestPermission();
    await _setupMessagingHandler();
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<void> setupFlutterNotification() async {
    if (_isInitialized) return;

    const channel = AndroidNotificationChannel(
      _channelId,
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        pendingPayload = details.payload;
        handleClickNotification();
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    _isInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = notification?.android;

    if (notification != null) {
      await _localNotification.show(
        0,
        notification.title ?? '',
        notification.body ?? '',
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<void> _setupMessagingHandler() async {
    FirebaseMessaging.onMessage.listen(showNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      pendingPayload = jsonEncode(message.data);
      handleClickNotification();
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      pendingPayload = jsonEncode(initialMessage.data);
    }
  }

  void handleClickNotification() {
    if (pendingPayload == null) return;

    try {
      final data = jsonDecode(pendingPayload!) as Map<String, dynamic>;
      final type = data['type'];
      final id = data['id'];

      if (type == 'invoice') {
        Get.toNamed('/invoice/detail/$id');
      } else if (type == 'chat') {
        Get.toNamed('/chat');
      }
    } catch (e) {
      print("Gagal parse payload: $e");
    }

    pendingPayload = null;
  }
}
