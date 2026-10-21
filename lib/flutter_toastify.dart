/// Özelleştirilebilir, animasyonlu toast bildirimleri.
///
/// Customizable, animated toast notifications.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';
import 'package:flutter_toastify/components/extensions.dart';
import 'package:flutter_toastify/widget/animated_progress_bar.dart';
import 'package:flutter_toastify/widget/flutter_toastify_content.dart';

export 'package:flutter_toastify/components/enums.dart';

/// Ekranın üzerinde [Overlay] ile gösterilen toast bildirimi.
///
/// [show] ile gösterilir, [closeOverlay] ile kapatılır.
class FlutterToastify extends StatefulWidget {
  /// [icon] ile özel görünümlü bir bildirim oluşturur.
  FlutterToastify({
    super.key,
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
  }) : notificationType = NotificationType.custom {
    checkAssertions();
  }

  /// Hazır başarı stiliyle bir bildirim oluşturur.
  FlutterToastify.success({
    super.key,
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
  })  : notificationType = NotificationType.success,
        progressIndicatorColor = NotificationType.success.color(),
        icon = null,
        shadowColor = Colors.grey,
        radius = 5.0,
        enableShadow = true {
    checkAssertions();
  }

  /// Hazır hata stiliyle bir bildirim oluşturur.
  FlutterToastify.error({
    super.key,
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
  })  : notificationType = NotificationType.error,
        progressIndicatorColor = NotificationType.error.color(),
        icon = null,
        shadowColor = Colors.grey,
        radius = 5.0,
        enableShadow = true {
    checkAssertions();
  }

  /// Hazır bilgi stiliyle bir bildirim oluşturur.
  FlutterToastify.info({
    super.key,
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
  })  : notificationType = NotificationType.info,
        progressIndicatorColor = NotificationType.info.color(),
        icon = null,
        shadowColor = Colors.grey,
        radius = 5.0,
        enableShadow = true {
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
  final Widget? icon;

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
  final Color shadowColor;

  /// Bildirimin arkaplan rengi
  /// Varsayılan olarak beyaz olarak ayarlanır
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final Color background;

  /// İlerleme çubuğunun rengi
  /// Varsayılan olarak mavi
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final Color progressIndicatorColor;

  /// Bildirim widget'ının kenar yarıçapı
  /// Sadece varsayılan yapıyı kullandığınızda bu parametre ayarlanır
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final double radius;

  /// Bildirimin ne kadar süreceği
  /// Varsayılan olarak 3000 milisaniye
  final Duration toastDuration;

  /// Gölge oluşturmayı etkinleştirme veya devre dışı bırakma
  /// Varsayılan olarak true
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final bool enableShadow;

  /// İlerleme göstergesi oluşturmayı etkinleştirme veya devre dışı bırakma
  /// Varsayılan olarak gösterilir
  /// Success, Info, Error türü yapılar için bu parametre değiştirilemez
  final bool showProgressIndicator;

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
  final NotificationType notificationType;

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

  /// Bildirim kapatma düğmesiyle kapatıldığında çağrılan fonksiyon
  final Function()? onDismiss;

  final _OverlayHandle _overlayHandle = _OverlayHandle();

  /// Bildirim gösteriliyorsa ona ait [OverlayEntry], aksi halde `null`
  OverlayEntry? get overlayEntry => _overlayHandle.entry;

  /// Bildirim şu anda ekranda mı
  bool get isShowing => _overlayHandle.entry != null;

  /// İlerleme göstergesi arka plan rengi
  /// Varsayılan olarak gri
  final Color progressIndicatorBackground;

  /// Ekranın üzerine bildirimi gösterir
  ///
  /// Aynı örnek zaten gösteriliyorsa tekrar eklenmez. [context] üstünde
  /// bir [Overlay] yoksa hiçbir şey yapmaz.
  void show(BuildContext context) {
    if (isShowing) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;
    final entry = _overlayEntryBuilder();
    _overlayHandle.entry = entry;
    overlay.insert(entry);
  }

  /// Overlay'ı kapatır
  void closeOverlay() {
    final entry = _overlayHandle.entry;
    if (entry == null) return;
    _overlayHandle.entry = null;
    entry.remove();
    entry.dispose();
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

/// [FlutterToastify] için durum sınıfı
class FlutterToastifyState extends State<FlutterToastify> with SingleTickerProviderStateMixin {
  /// Otomatik kapanma zamanlayıcısı, `autoDismiss == false` ise `null`
  Timer? closeTimer;

  /// Giriş/çıkış kaydırma animasyonu
  late Animation<Offset> offsetAnimation;

  /// Kaydırma animasyonunun denetleyicisi
  late AnimationController slideController;

  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    if (widget.autoDismiss) {
      closeTimer = Timer(widget.toastDuration, () {
        _close(widget.onProgressFinished);
      });
    }
  }

  void _initializeAnimation() {
    slideController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    final Offset begin = switch (widget.animation) {
      AnimationType.fromLeft => const Offset(-2, 0),
      AnimationType.fromRight => const Offset(2, 0),
      AnimationType.fromTop => const Offset(0, -7),
      AnimationType.fromBottom => const Offset(0, 4),
    };
    offsetAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.ease,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isClosing) slideController.forward();
    });
  }

  /// Çıkış animasyonunu oynatır, ardından bildirimi overlay'dan kaldırır.
  void _close([void Function()? callback]) {
    if (_isClosing) return;
    _isClosing = true;
    closeTimer?.cancel();
    callback?.call();
    slideController.reverse().then((_) {
      if (mounted) widget.closeOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return SlideTransition(
      position: offsetAnimation,
      child: Container(
        width: widget.width ?? screenSize.width * 0.7,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.background,
          boxShadow: widget.enableShadow
              ? [
                  BoxShadow(
                    color: widget.shadowColor.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _sizedContent(
              screenSize,
              FlutterToastifyContent(
                title: widget.title,
                description: widget.description,
                notificationType: widget.notificationType,
                icon: widget.icon,
                displayCloseButton: widget.displayCloseButton,
                closeButton: widget.closeButton,
                onCloseButtonPressed: () => _close(() {
                  widget.onCloseButtonPressed?.call();
                  widget.onDismiss?.call();
                }),
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

  /// [FlutterToastify.height] verilmişse içerik o yüksekliği doldurur; verilmemişse
  /// en az ekran yüksekliğinin %12'si kadar olur ve uzun metinde taşmadan büyür.
  Widget _sizedContent(Size screenSize, Widget content) {
    if (widget.height != null) return Expanded(child: content);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenSize.height * 0.12),
      child: IntrinsicHeight(child: content),
    );
  }

  @override
  void dispose() {
    closeTimer?.cancel();
    slideController.dispose();
    super.dispose();
  }
}

/// Widget'ı değişmez tutarken gösterilen [OverlayEntry]'yi saklar.
class _OverlayHandle {
  OverlayEntry? entry;
}
