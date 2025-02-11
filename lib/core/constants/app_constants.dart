import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

showSnackBar(String title, {SnackBarAction? snackbarAction}) {
  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(title),
    action: snackbarAction,
  ));
}
