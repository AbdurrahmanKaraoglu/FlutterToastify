/// Customizable, animated toast notifications for Flutter.
///
/// Flutter için özelleştirilebilir, animasyonlu toast bildirimleri.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';
import 'package:flutter_toastify/components/extensions.dart';
import 'package:flutter_toastify/widget/animated_progress_bar.dart';
import 'package:flutter_toastify/widget/flutter_toastify_content.dart';

export 'package:flutter_toastify/components/enums.dart';

/// A toast notification shown above the app through the root [Overlay].
///
/// Create one with [FlutterToastify.success], [FlutterToastify.error],
/// [FlutterToastify.info] or the custom [FlutterToastify.new] constructor,
/// display it with [show] and remove it early with [closeOverlay].
///
/// ```dart
/// FlutterToastify.success(
///   title: const Text('Update'),
///   description: const Text('Your data has been updated'),
/// ).show(context);
/// ```
///
/// Kök [Overlay] üzerinde gösterilen toast bildirimi. Hazır kuruculardan
/// biriyle oluşturulur, [show] ile gösterilir, [closeOverlay] ile kapatılır.
class FlutterToastify extends StatefulWidget {
  /// Creates a notification with your own [icon] and colors.
  ///
  /// [icon] ve renklerle özel görünümlü bir bildirim oluşturur.
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

  /// Creates a notification in the built-in success style (green).
  ///
  /// Hazır başarı (yeşil) stiliyle bir bildirim oluşturur.
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

  /// Creates a notification in the built-in error style (red).
  ///
  /// Hazır hata (kırmızı) stiliyle bir bildirim oluşturur.
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

  /// Creates a notification in the built-in info style (blue).
  ///
  /// Hazır bilgi (mavi) stiliyle bir bildirim oluşturur.
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

  /// Asserts (in debug mode) that the options are consistent: a progress
  /// indicator needs [autoDismiss], an [action] needs [onActionPressed], and
  /// [animation] must come from a side that matches [notificationPosition].
  ///
  /// Seçeneklerin tutarlılığını (debug modda) doğrular.
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

  /// Optional title shown above [description].
  ///
  /// [description] üstünde gösterilen isteğe bağlı başlık.
  final Widget? title;

  /// Main content of the notification.
  ///
  /// Bildirimin ana içeriği.
  final Widget description;

  /// Leading icon of a custom notification. Built-in styles use their own icon.
  ///
  /// Özel bildirimin ikonu; hazır stiller kendi ikonlarını kullanır.
  final Widget? icon;

  /// Size of the built-in style icons. Defaults to 20.
  ///
  /// Hazır stil ikonlarının boyutu, varsayılan 20.
  final double iconSize;

  /// Side the notification slides in from. Defaults to [AnimationType.fromRight].
  ///
  /// Bildirimin kayarak geldiği yön, varsayılan [AnimationType.fromRight].
  final AnimationType animation;

  /// Duration of the slide in and slide out animation. Defaults to 600 ms.
  ///
  /// Giriş ve çıkış animasyonunun süresi, varsayılan 600 ms.
  final Duration animationDuration;

  /// Shadow color. Defaults to [Colors.grey]; fixed for built-in styles.
  ///
  /// Gölge rengi, varsayılan gri; hazır stillerde değiştirilemez.
  final Color shadowColor;

  /// Background color. Defaults to [Colors.white].
  ///
  /// Arka plan rengi, varsayılan beyaz.
  final Color background;

  /// Progress bar color. Defaults to blue; built-in styles use their own color.
  ///
  /// İlerleme çubuğu rengi, varsayılan mavi; hazır stiller kendi rengini kullanır.
  final Color progressIndicatorColor;

  /// Corner radius. Defaults to 5; fixed for built-in styles.
  ///
  /// Köşe yarıçapı, varsayılan 5; hazır stillerde değiştirilemez.
  final double radius;

  /// How long the notification stays on screen when [autoDismiss] is true.
  /// Defaults to 3 seconds.
  ///
  /// [autoDismiss] açıkken ekranda kalma süresi, varsayılan 3 saniye.
  final Duration toastDuration;

  /// Whether to draw a shadow. Defaults to true; fixed for built-in styles.
  ///
  /// Gölge çizilsin mi, varsayılan true; hazır stillerde değiştirilemez.
  final bool enableShadow;

  /// Whether to show the remaining time bar. Requires [autoDismiss].
  /// Defaults to true.
  ///
  /// Kalan süre çubuğu gösterilsin mi; [autoDismiss] gerektirir, varsayılan true.
  final bool showProgressIndicator;

  /// Whether to show the close button. Defaults to true.
  ///
  /// Kapatma düğmesi gösterilsin mi, varsayılan true.
  final bool displayCloseButton;

  /// Builds a custom close button. Call the given `dismissNotification`
  /// callback to close the notification. When null, a default 48x48 close
  /// button with a localized screen reader label is used.
  ///
  /// Özel kapatma düğmesi oluşturur; kapatmak için verilen fonksiyonu çağırın.
  /// `null` ise varsayılan düğme kullanılır.
  final Widget Function(void Function() dismissNotification)? closeButton;

  /// Called when the user presses the close button.
  ///
  /// Kullanıcı kapatma düğmesine bastığında çağrılır.
  final VoidCallback? onCloseButtonPressed;

  /// Called when the notification closes itself after [toastDuration].
  ///
  /// Bildirim süre dolup kendiliğinden kapandığında çağrılır.
  final VoidCallback? onProgressFinished;

  /// Style of the notification, set by the constructor that was used.
  ///
  /// Bildirimin türü; kullanılan kurucu tarafından belirlenir.
  final NotificationType notificationType;

  /// Where the notification appears on screen.
  /// Defaults to [NotificationPosition.topRight].
  ///
  /// Bildirimin ekrandaki konumu, varsayılan [NotificationPosition.topRight].
  final NotificationPosition notificationPosition;

  /// Optional tappable widget shown under [description], such as a link.
  ///
  /// [description] altında gösterilen isteğe bağlı tıklanabilir bileşen.
  final Widget? action;

  /// Called when [action] is tapped. Required when [action] is set.
  ///
  /// [action] tıklandığında çağrılır; [action] verilirse zorunludur.
  final VoidCallback? onActionPressed;

  /// Whether the notification closes itself after [toastDuration].
  /// Defaults to true.
  ///
  /// Bildirim süre dolunca kendiliğinden kapansın mı, varsayılan true.
  final bool autoDismiss;

  /// Width of the notification. Defaults to 70% of the screen width.
  ///
  /// Bildirimin genişliği, varsayılan ekran genişliğinin %70'i.
  final double? width;

  /// Fixed height of the notification. When null, it is at least 12% of the
  /// screen height and grows with its content.
  ///
  /// Sabit yükseklik; `null` ise en az ekranın %12'si olur ve içeriğe göre büyür.
  final double? height;

  /// Called when the notification is closed with the close button.
  ///
  /// Bildirim kapatma düğmesiyle kapatıldığında çağrılır.
  final VoidCallback? onDismiss;

  final _OverlayHandle _overlayHandle = _OverlayHandle();

  /// The [OverlayEntry] of the notification while it is shown, otherwise null.
  ///
  /// Bildirim gösterilirken ona ait [OverlayEntry], aksi halde `null`.
  OverlayEntry? get overlayEntry => _overlayHandle.entry;

  /// Whether this notification is currently shown.
  ///
  /// Bildirim şu anda ekranda mı.
  bool get isShowing => _overlayHandle.entry != null;

  /// Track color of the progress bar. Defaults to light grey.
  ///
  /// İlerleme çubuğunun arka plan rengi, varsayılan açık gri.
  final Color progressIndicatorBackground;

  /// Shows the notification above the app.
  ///
  /// Does nothing if this instance is already shown or there is no [Overlay]
  /// above [context].
  ///
  /// Bildirimi gösterir. Zaten gösteriliyorsa ya da [context] üstünde bir
  /// [Overlay] yoksa hiçbir şey yapmaz.
  void show(BuildContext context) {
    if (isShowing) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;
    final entry = _overlayEntryBuilder();
    _overlayHandle.entry = entry;
    overlay.insert(entry);
  }

  /// Removes the notification immediately, without the slide out animation.
  ///
  /// Bildirimi çıkış animasyonu olmadan hemen kaldırır.
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
        // AlertDialog bilinçli olarak kullanılmıyor: MaterialLocalizations ister
        // (CupertinoApp'te iOS/macOS'ta çöker), uygulamanın DialogTheme'ini devralır
        // ve ekran okuyucuya bildirimi diyalog olarak bildirir.
        return SafeArea(
          child: AnimatedPadding(
            padding: MediaQuery.viewInsetsOf(context) + const EdgeInsets.all(30),
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Align(
              alignment: notificationPosition.alignment,
              child: Semantics(
                container: true,
                liveRegion: true,
                child: Material(
                  type: MaterialType.transparency,
                  child: this,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  FlutterToastifyState createState() => FlutterToastifyState();
}

/// State of a [FlutterToastify]. / [FlutterToastify] için durum sınıfı.
class FlutterToastifyState extends State<FlutterToastify> with SingleTickerProviderStateMixin {
  /// Auto dismiss timer, null when `autoDismiss` is false.
  ///
  /// Otomatik kapanma zamanlayıcısı; `autoDismiss` kapalıysa `null`.
  Timer? closeTimer;

  /// Slide in and slide out animation. / Giriş ve çıkış kaydırma animasyonu.
  late Animation<Offset> offsetAnimation;

  /// Controller of [offsetAnimation]. / [offsetAnimation] denetleyicisi.
  late AnimationController slideController;

  bool _isClosing = false;

  /// Bu durumun ait olduğu [OverlayEntry], widget doğrudan ağaca konduysa `null`.
  OverlayEntry? _ownEntry;

  @override
  void initState() {
    super.initState();
    _ownEntry = widget._overlayHandle.entry;
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
                // Sabit yükseklik verildiyse yerleşim önceki sürümlerle aynı kalır.
                verticalPadding: widget.height == null ? AppConstants.contentVerticalPadding : 0,
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
    // Overlay bildirimden önce yok edildiyse (ör. uygulama ağacı değişti) kayıt
    // temizlenir; aksi halde isShowing true kalır ve bildirim bir daha gösterilemez.
    final handle = widget._overlayHandle;
    if (handle.entry != null && handle.entry == _ownEntry) handle.entry = null;
    closeTimer?.cancel();
    slideController.dispose();
    super.dispose();
  }
}

/// Widget'ı değişmez tutarken gösterilen [OverlayEntry]'yi saklar.
class _OverlayHandle {
  OverlayEntry? entry;
}
