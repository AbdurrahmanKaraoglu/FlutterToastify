/// flutter_toastify kütüphanesi
library flutter_toastify;
import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';
import 'package:flutter_toastify/components/extensions.dart';
import 'package:flutter_toastify/widget/animated_progress_bar.dart';
import 'package:flutter_toastify/widget/flutter_toastify_conten.dart';

import 'dart:async';

 
/// ignore: must_be_immutable
class FlutterToastify extends StatefulWidget {
  FlutterToastify({
    Key? key,
    this.title,
    required this.description,
    required this.icon,
    this.shadowColor = Colors.grey,
    this.background = Colors.white,
    this.radius = 5.0,
    this.enableShadow = true,
    this.showProgressIndicator = true,
    this.closeButton,
    this.progressIndicatorColor = Colors.blue,
    this.toastDuration = const Duration(milliseconds: 3000),
    this.displayCloseButton = true,
    this.onCloseButtonPressed,
    this.onProgressFinished,
    this.notificationPosition = NotificationPosition.topRight,
    this.animation = AnimationType.fromRight,
    this.animationDuration = const Duration(milliseconds: 600),
    this.iconSize = AppConstants.defaultIconSize,
    this.action,
    this.onActionPressed,
    this.autoDismiss = true,
    this.height,
    this.width,
    this.onDismiss,
    this.progressIndicatorBackground = AppConstants.greyColor,
  }) : super(key: key) {
    notificationType = NotificationType.custom;
    checkAssertions();
  }

  FlutterToastify.success({
    Key? key,
    this.title,
    required this.description,
    this.background = Colors.white,
    this.closeButton,
    this.toastDuration = const Duration(milliseconds: 3000),
    this.displayCloseButton = true,
    this.onCloseButtonPressed,
    this.onProgressFinished,
    this.iconSize = AppConstants.defaultIconSize,
    this.notificationPosition = NotificationPosition.topRight,
    this.animation = AnimationType.fromRight,
    this.animationDuration = const Duration(milliseconds: 600),
    this.showProgressIndicator = true,
    this.action,
    this.onActionPressed,
    this.autoDismiss = true,
    this.height,
    this.width,
    this.onDismiss,
    this.progressIndicatorBackground = AppConstants.greyColor,
  }) : super(key: key) {
    notificationType = NotificationType.success;
    progressIndicatorColor = notificationType.color();
    icon = null;
    checkAssertions();
  }

  FlutterToastify.error({
    Key? key,
    this.title,
    required this.description,
    this.background = Colors.white,
    this.closeButton,
    this.toastDuration = const Duration(milliseconds: 3000),
    this.displayCloseButton = true,
    this.onCloseButtonPressed,
    this.onProgressFinished,
    this.iconSize = AppConstants.defaultIconSize,
    this.notificationPosition = NotificationPosition.topRight,
    this.animation = AnimationType.fromRight,
    this.animationDuration = const Duration(milliseconds: 600),
    this.showProgressIndicator = true,
    this.action,
    this.onActionPressed,
    this.autoDismiss = true,
    this.height,
    this.width,
    this.onDismiss,
    this.progressIndicatorBackground = AppConstants.greyColor,
  }) : super(key: key) {
    notificationType = NotificationType.error;
    progressIndicatorColor = notificationType.color();
    icon = null;
    checkAssertions();
  }

  FlutterToastify.info({
    Key? key,
    this.title,
    required this.description,
    this.background = Colors.white,
    this.closeButton,
    this.toastDuration = const Duration(milliseconds: 3000),
    this.displayCloseButton = true,
    this.onCloseButtonPressed,
    this.onProgressFinished,
    this.iconSize = AppConstants.defaultIconSize,
    this.notificationPosition = NotificationPosition.topRight,
    this.animation = AnimationType.fromRight,
    this.animationDuration = const Duration(milliseconds: 600),
    this.showProgressIndicator = true,
    this.action,
    this.onActionPressed,
    this.autoDismiss = true,
    this.height,
    this.width,
    this.onDismiss,
    this.progressIndicatorBackground = AppConstants.greyColor,
  }) : super(key: key) {
    notificationType = NotificationType.info;
    progressIndicatorColor = notificationType.color();
    icon = null;
    checkAssertions();
  }

  /// Farklı seçeneklerin sağlanmasını sağlamak için bir dizi kontrol gerçekleştirir
  void checkAssertions() {
    if (showProgressIndicator) {
      assert(autoDismiss != false);
    }
    if (action != null) {
      assert(onActionPressed != null);
    }

    if (notificationPosition == NotificationPosition.centerRight) {
      assert(
        animation != AnimationType.fromLeft && animation != AnimationType.fromBottom && animation != AnimationType.fromTop,
      );
    } else if (notificationPosition == NotificationPosition.centerLeft) {
      assert(
        animation != AnimationType.fromRight && animation != AnimationType.fromBottom && animation != AnimationType.fromTop,
      );
    } else if (notificationPosition == NotificationPosition.topCenter) {
      assert(
        animation != AnimationType.fromBottom && animation != AnimationType.fromLeft && animation != AnimationType.fromRight,
      );
    } else if (notificationPosition == NotificationPosition.topRight) {
      assert(
        animation != AnimationType.fromLeft && animation != AnimationType.fromBottom,
      );
    } else if (notificationPosition == NotificationPosition.topLeft) {
      assert(
        animation != AnimationType.fromRight && animation != AnimationType.fromBottom,
      );
    } else if (notificationPosition == NotificationPosition.bottomCenter) {
      assert(
        animation != AnimationType.fromTop && animation != AnimationType.fromLeft && animation != AnimationType.fromRight,
      );
    } else if (notificationPosition == NotificationPosition.bottomRight) {
      assert(
        animation != AnimationType.fromLeft && animation != AnimationType.fromTop,
      );
    } else if (notificationPosition == NotificationPosition.bottomLeft) {
      assert(
        animation != AnimationType.fromRight && animation != AnimationType.fromTop,
      );
    }
  }

  /// Bildirim başlığı widget'ı
  final Widget? title;

  /// Bildirim açıklama widget'ı
  final Widget description;

  /// Bildirim ikonu, sadece varsayılan yapıyı kullanan diğer bildirim türleri (Success, Info, Error) için gerekli
  late Widget? icon;

  /// İkon boyutu, varsayılan olarak 20px
  final double iconSize;

  /// Bildirime uygulanan animasyon türü
  /// Mümkün olan değerler:
  /// fromLeft, fromRight, fromTop, fromBottom
  /// Varsayılan değer: fromRight
  final AnimationType animation;

  /// Animasyon süresi
  /// Varsayılan değer: Duration(milliseconds: 600)
  final Duration animationDuration;

  /// Bildirim widget'ının gölge rengi
  /// Varsayılan olarak Colors.grey
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  late Color shadowColor = Colors.grey;

  /// Bildirimin arkaplan rengi
  /// Varsayılan olarak beyaz olarak ayarlanır
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  late Color background;

  /// İlerleme çubuğunun rengi
  /// Varsayılan olarak mavi
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  late Color progressIndicatorColor;

  /// Bildirim widget'ının kenar yarıçapı
  /// Sadece varsayılan yapıyı kullandığınızda bu parametre ayarlanır
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  late double radius = 5.0;

  /// Bildirimin ne kadar süreceği
  /// Varsayılan olarak 3000 milisaniye
  final Duration toastDuration;

  /// Gölge oluşturmayı etkinleştirme veya devre dışı bırakma
  /// Varsayılan olarak true
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  late bool enableShadow = true;

  /// İlerleme göstergesi oluşturmayı etkinleştirme veya devre dışı bırakma
  /// Varsayılan olarak gösterilir
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  late bool showProgressIndicator;

  /// Kapat düğmesini görüntüleyin veya gizleyin
  /// Varsayılan olarak kapat düğmesi görüntülenir
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final bool displayCloseButton;

  /// Kapatma düğmesi olarak gösterilecek widget
  /// Varsayılan olarak kapat düğmesi görüntülenir, eğer istemezseniz closeButton'a null değeri verin
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final Widget Function(void Function() dismissNotification)? closeButton;

  /// Kullanıcı kapatma düğmesine bastığında çağrılan fonksiyon
  final Function()? onCloseButtonPressed;

  /// İlerleme göstergisi tamamlandıktan sonra bildirimin kapatılması durumunda çağrılan fonksiyon
  final Function()? onProgressFinished;

  /// Bildirim türü, her yapılandırmacıda otomatik olarak ayarlanır
  /// Mümkün olan değerler: success, error, info, custom
  late NotificationType notificationType;

  /// Bildirim hizalamasının türü
  /// Mümkün olan değerler: top, center, bottom
  /// Varsayılan değer: top
  final NotificationPosition notificationPosition;

  /// Tıklanabilir inkwell ile görüntülenen eylem bileşeni
  /// Varsayılan olarak action null'dır
  final Widget? action;

  /// Eylem bileşenine tıklandığında çağrılan fonksiyon
  /// action null değilse onActionPressed null olmamalıdır
  final Function()? onActionPressed;

  /// Bildirimin otomatik olarak kapatılıp kapatılmayacağını belirler
  /// Varsayılan olarak autoDismiss == true
  final bool autoDismiss;

  /// Bildirim widget'ının genişliği
  final double? width;

  /// Bildirim widget'ının yüksekliği
  final double? height;

  /// Bildirimin dışında tıklanarak veya telefonun geri düğmesine basılarak veya ekrana tıklanarak çağrılan fonksiyon
  final Function()? onDismiss;

  /// Eğilimli bir bildiri oluşturur
  OverlayEntry? overlayEntry;

  /// İlerleme göstergesi arka plan rengi
  /// Varsayılan olarak gri
  final Color progressIndicatorBackground;

  /// Ekranın üzerine bildirimi gösterir
  void show(BuildContext context) {
    overlayEntry = _overlayEntryBuilder();
    Overlay.maybeOf(context)?.insert(overlayEntry!);
  }

  /// Overlay'ı kapatır
  void closeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      opaque: false,
      builder: (context) {
        return SafeArea(
          child: AlertDialog(
            alignment: notificationPosition.alignment,
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(30),
            elevation: 0,
            content: this,
          ),
        );
      },
    );
  }

  @override
  FlutterToastifyState createState() => FlutterToastifyState();
}

class FlutterToastifyState extends State<FlutterToastify> with SingleTickerProviderStateMixin {
  late Timer closeTimer;
  late Animation<Offset> offsetAnimation;
  late AnimationController slideController;

  @override
  void initState() {
    super.initState();

    closeTimer = Timer(widget.toastDuration, () {
      slideController.reverse();
      slideController.addListener(() {
        if (slideController.isDismissed) {
          widget.onProgressFinished?.call();
          widget.closeOverlay();
        }
      });
    });
    if (!widget.autoDismiss) {
      closeTimer.cancel();
    }
    _initializeAnimation();
  }

  void _initializeAnimation() {
    slideController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    switch (widget.animation) {
      case AnimationType.fromLeft:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(-2, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: Curves.ease,
          ),
        );
        break;
      case AnimationType.fromRight:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(2, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: Curves.ease,
          ),
        );
        break;
      case AnimationType.fromTop:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(0, -7),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: Curves.ease,
          ),
        );
        break;
      case AnimationType.fromBottom:
        offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 4),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: slideController,
            curve: Curves.ease,
          ),
        );
        break;
      default:
    }

    // ! Flutter < 3.0.0 için desteklemek için
    /// T veya T? türündeki bir değeri T? türüne dönüştürmeye yarar
    ///
    /// Bu, artık null olmayan API'leri kullanmaya izin vermek için
    /// `!` ve `?` ile eski sürümleri de desteklemek için kullanılır
    T? ambiguate<T>(T? value) => value;

    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback(
      (_) => slideController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width * 0.7,
        height: widget.height ?? MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.background,
          boxShadow: widget.enableShadow
              ? [
                  BoxShadow(
                    color: widget.shadowColor.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), /// gölgenin pozisyonunu değiştirir
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Expanded(
              child: FlutterToastifyContent(
                title: widget.title,
                description: widget.description,
                notificationType: widget.notificationType,
                icon: widget.icon,
                displayCloseButton: widget.displayCloseButton,
                closeButton: widget.closeButton,
                onCloseButtonPressed: () {
                  widget.onCloseButtonPressed?.call();
                  closeTimer.cancel();
                  slideController.reverse();
                  widget.onDismiss?.call();
                  widget.closeOverlay();
                },
                iconSize: widget.iconSize,
                action: widget.action,
                onActionPressed: widget.onActionPressed,
              ),
            ),
            if (widget.showProgressIndicator)
              AnimatedProgressBar(
                foregroundColor: widget.progressIndicatorColor,
                duration: widget.toastDuration,
                backgroundColor: widget.progressIndicatorBackground,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    slideController.dispose();
    closeTimer.cancel();
    super.dispose();
  }
}
