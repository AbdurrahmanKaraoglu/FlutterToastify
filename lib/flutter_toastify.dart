library flutter_toastify;

import 'package:flutter/material.dart';
import 'package:flutter_toastify/enums.dart';



class FlutterToastify {
  final String message;
  final NotificationPosition position;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final Duration duration;
  final AnimationType animation;

  FlutterToastify({
    required this.message,
    this.position = NotificationPosition.bottomCenter,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.duration = const Duration(seconds: 2),
    this.animation = AnimationType.fromBottom,
  });

  void show(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
        vertical: position == NotificationPosition.bottomCenter ? 20.0 : 0.0,
        horizontal: position == NotificationPosition.center ? 20.0 : 0.0,
      ),
    );

    scaffold.showSnackBar(snackBar).closed.then((reason) {
      if (animation == AnimationType.fromBottom) {
        // Tetikleyerek rebuild yapma işlemini başlatıyoruz.
        setState(() {});
      }
    });
  }

  void setState(VoidCallback fn) {
    // Dummy method to trigger rebuild when using fromBottom animation
    // Bu işlev, setState kullanmadan build işlemini tetiklemek için kullanılabilir,
    // fakat uygulama kodunda kullanılmıyor.
  }
}
