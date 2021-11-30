import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificacaoService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notificationsPlugin.initialize(settings);
  }

  static NotificationDetails _getNotificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) =>
      _notificationsPlugin.show(id, title, body, _getNotificationDetails(),
          payload: payload);
}
