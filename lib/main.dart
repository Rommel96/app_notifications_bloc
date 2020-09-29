import 'package:flutter/material.dart';
import 'package:local_notifications/app_notifications.dart';
import 'package:local_notifications/config/notifications_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ConfigNotifications configNotifications = ConfigNotifications();
  await configNotifications.initConfig();
  runApp(AppNotifications());
}
