import 'package:flutter/material.dart';
import 'package:local_notifications/bloc/base_bloc.dart';
import 'package:local_notifications/bloc/notifcations_bloc.dart';

class BlocProviderNotications extends StatefulWidget {
  final Widget child;
  final NotificationsBloc bloc;

  const BlocProviderNotications(
      {Key key, @required this.child, @required this.bloc})
      : super(key: key);

  static BlocProviderNotications of<NotificationsBloc extends BaseBloc>(
          BuildContext context) =>
      context.findAncestorWidgetOfExactType();

  @override
  State<StatefulWidget> createState() => _BlocProviderNotications();
}

class _BlocProviderNotications extends State<BlocProviderNotications> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
