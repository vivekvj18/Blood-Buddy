// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class SLocalNotification {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initialize() {
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//     );

//     _notificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (String? id) async {
//         if (id!.isNotEmpty) {}
//       },
//     );
//   }

//   static void show(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel', // id
//           'High Importance Notifications', // title
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       );
//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data['_id'],
//       );
//     } on Exception catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }
// }
