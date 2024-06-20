import 'package:flutter/material.dart';

class ScaffoldService {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  GlobalKey<ScaffoldState> get newScaffoldKey {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    return _scaffoldKey;
  }

  final snackBarDuration = const Duration(seconds: 4);

  void _safeShowSnackBarMessage(String msg, {Duration? duration}) {
    if (scaffoldKey.currentState == null) return;

    final sfm = ScaffoldMessenger.of(
      scaffoldKey.currentState!.context,
    );

    sfm
        .showSnackBar(
          SnackBar(
            content: Text(msg),
            duration: duration ?? snackBarDuration,
          ),
        )
        .closed
        .then(
          (value) => sfm.clearSnackBars(),
        );
  }

  void showSnackBarMessage(String msg, {Duration? duration}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _safeShowSnackBarMessage(msg, duration: duration),
    );
  }
}
