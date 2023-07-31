library flutter_toastify;

import 'package:flutter/material.dart';
import 'package:flutter_toastify/enums.dart';
import 'package:flutter_toastify/widget/animated_progress_bar.dart';

class FlutterToastify extends StatefulWidget {
  const FlutterToastify(
      {super.key, this.title, required this.description, required this.type, required this.showProgressIndicator, required this.duration, required this.autoDismiss, this.onCloseButtonPressed});
  final String? title;
  final String description;
  final FlutterToastifyType type;
  final bool showProgressIndicator;
  final Duration duration;
  final bool autoDismiss;
  final Function()? onCloseButtonPressed;
  @override
  State<FlutterToastify> createState() => _FlutterToastifyState();
}

class _FlutterToastifyState extends State<FlutterToastify> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
    if (widget.autoDismiss) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _dismissNotification();
        }
      });
    }
  }

  void _dismissNotification() {
    _controller.reverse().whenComplete(() {
      widget.onCloseButtonPressed?.call();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AlertDialog(
        title: widget.title != null ? Text(widget.title!) : null,
        content: Text(widget.description),
        actions: [
          if (widget.showProgressIndicator) AnimatedProgressBar(duration: widget.duration),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _dismissNotification,
          ),
        ],
      ),
    );
  }
}
 
 
 

 

// Kullanım Örneği:
// FlutterToastify(
//   title: 'Başlık',
//   description: 'Bildirim açıklaması',
//   type: FlutterToastifyType.info,
//   showProgressIndicator: true,
//   duration: Duration(milliseconds: 3000),
//   autoDismiss: true,
//   onCloseButtonPressed: () {
//     // Bildirim kapatıldığında yapılacak işlemler
//   },
// )
