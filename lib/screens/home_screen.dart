import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_notifications/bloc/notifcations_bloc.dart';
import 'package:local_notifications/config/notifications_methods.dart';
import 'package:local_notifications/provider/provider_notifcations.dart';
import 'package:local_notifications/screens/second_sreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationsBloc _notificationsBloc;
  @override
  void initState() {
    super.initState();
    _notificationsBloc =
        BlocProviderNotications.of<NotificationsBloc>(context).bloc;
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _configureDidReceiveLocalNotificationSubject() {
    _notificationsBloc.streamDidReceiveLocalNotificationSubject
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondScreen(payload: receivedNotification.payload),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    _notificationsBloc.streamSelectNotificationSubject
        .listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen(payload: payload)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Notified"),
          onPressed: () => _notificationsBloc
              .didReceiveLocalNotificationSubject(ReceivedNotification(
            id: 1,
            title: 'title',
            body: 'body',
            payload: 'payload',
          )),
        ),
      ),
    );
  }
}
