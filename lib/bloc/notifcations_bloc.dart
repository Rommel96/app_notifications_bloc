import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/bloc/base_bloc.dart';
import 'package:local_notifications/config/notifications_methods.dart';

class NotificationsBloc implements BaseBloc {
  //NotificationsBloc(this.configNotifications);
  //final ConfigNotifications configNotifications;
  final StreamController<ReceivedNotification> _controllerDidReceived =
      StreamController<ReceivedNotification>();

  final StreamController<String> _controllerSelected =
      StreamController<String>();

  Stream<ReceivedNotification> get streamDidReceiveLocalNotificationSubject =>
      _controllerDidReceived.stream;

  Stream<String> get streamSelectNotificationSubject =>
      _controllerSelected.stream;

  void didReceiveLocalNotificationSubject(ReceivedNotification notification) {
    _controllerDidReceived.sink.add(notification);
    _showNotification(notification);
  }

  void selectNotificationSubject(String payload) {
    _controllerSelected.sink.add(payload);
  }

  Future<void> _showNotification(ReceivedNotification notification) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(notification.id,
        notification.title, notification.body, platformChannelSpecifics,
        payload: notification.payload);
  }

  @override
  void dispose() {
    _controllerDidReceived.close();
    _controllerSelected.close();
    print("dispose notifications");
  }
}
