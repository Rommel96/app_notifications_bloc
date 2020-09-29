import 'package:flutter/material.dart';
import 'package:local_notifications/bloc/notifcations_bloc.dart';
import 'package:local_notifications/config/notifications_methods.dart';
import 'package:local_notifications/provider/provider_notifcations.dart';
import 'package:local_notifications/screens/home_screen.dart';

class AppNotifications extends StatelessWidget {
  const AppNotifications({Key key, this.configNotifications}) : super(key: key);
  final ConfigNotifications configNotifications;

  @override
  Widget build(BuildContext context) {
    return BlocProviderNotications(
      bloc: NotificationsBloc(configNotifications),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Notifications',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
