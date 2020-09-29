import 'dart:async';

import 'package:local_notifications/bloc/base_bloc.dart';
import 'package:local_notifications/config/notifications_methods.dart';

class NotificationsBloc implements BaseBloc {
  NotificationsBloc(this.configNotifications);
  final ConfigNotifications configNotifications;
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
  }

  void selectNotificationSubject(String payload) {
    _controllerSelected.sink.add(payload);
  }

  @override
  void dispose() {
    _controllerDidReceived.close();
    _controllerSelected.close();
    print("dispose notifications");
  }
}
