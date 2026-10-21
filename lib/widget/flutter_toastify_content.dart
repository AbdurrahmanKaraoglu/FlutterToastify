import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';

/// The inner layout of a notification: icon, divider, title, description,
/// optional action and close button. Used by `FlutterToastify`; you rarely
/// need it directly.
///
/// Bildirimin iç yerleşimi: ikon, ayraç, başlık, açıklama, isteğe bağlı eylem
/// ve kapatma düğmesi. `FlutterToastify` tarafından kullanılır.
class FlutterToastifyContent extends StatelessWidget {
  /// Creates the notification content. / Bildirim içeriğini oluşturur.
  const FlutterToastifyContent({
    super.key,
    this.title,
    required this.description,
    required this.notificationType,
    required this.displayCloseButton,
    required this.onCloseButtonPressed,
    this.closeButton,
    this.icon,
    this.iconSize = 20,
    this.action,
    this.onActionPressed,
    this.verticalPadding = 0,
  });

  /// Top and bottom padding of the text column.
  ///
  /// Metin sütununun üst ve alt boşluğu.
  final double verticalPadding;

  /// Optional title. / İsteğe bağlı başlık.
  final Widget? title;

  /// Main content. / Ana içerik.
  final Widget description;

  /// Icon of a custom notification. / Özel bildirimin ikonu.
  final Widget? icon;

  /// Size of the built-in style icons. / Hazır stil ikonlarının boyutu.
  final double iconSize;

  /// Style that decides which icon is shown. / Hangi ikonun gösterileceğini belirleyen tür.
  final NotificationType notificationType;

  /// Called when the close button is pressed. / Kapatma düğmesine basıldığında çağrılır.
  final VoidCallback onCloseButtonPressed;

  /// Whether to show the close button. / Kapatma düğmesi gösterilsin mi.
  final bool displayCloseButton;

  /// Builds a custom close button; null uses the default one.
  ///
  /// Özel kapatma düğmesi oluşturur; `null` ise varsayılan kullanılır.
  final Widget Function(void Function() dismissNotification)? closeButton;

  /// Optional tappable widget under the description. / Açıklama altındaki isteğe bağlı tıklanabilir bileşen.
  final Widget? action;

  /// Called when [action] is tapped. / [action] tıklandığında çağrılır.
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Row(
      children: [
        Padding(
          padding: isRtl ? const EdgeInsets.only(right: AppConstants.horizontalPadding) : const EdgeInsets.only(left: AppConstants.horizontalPadding),
          child: _getNotificationIcon(),
        ),
        const SizedBox(
          width: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Container(
            width: 1,
            color: AppConstants.greyColor,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null) ...[
                  title!,
                  const SizedBox(
                    height: 5,
                  ),
                ],
                description,
                if (action != null) ...[
                  const SizedBox(
                    height: 5,
                  ),
                  onActionPressed == null
                      ? action!
                      : InkWell(
                          onTap: onActionPressed,
                          child: action!,
                        )
                ]
              ],
            ),
          ),
        ),
        Visibility(
          visible: displayCloseButton,
          child: closeButton?.call(onCloseButtonPressed) ?? _defaultCloseButton(context),
        )
      ],
    );
  }

  /// Default close button: at least 48x48 with a localized screen reader label.
  ///
  /// Varsayılan kapatma düğmesi: en az 48x48, ekran okuyucu etiketli.
  Widget _defaultCloseButton(BuildContext context) {
    final String label = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations)?.closeButtonTooltip ?? 'Close';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Semantics(
            container: true,
            button: true,
            label: label,
            excludeSemantics: true,
            child: InkWell(
              onTap: onCloseButtonPressed,
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: AppConstants.minTapTargetSize,
                height: AppConstants.minTapTargetSize,
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getNotificationIcon() {
    switch (notificationType) {
      case NotificationType.success:
        return _renderImage('assets/icons/success.png');
      case NotificationType.error:
        return _renderImage('assets/icons/error.png');
      case NotificationType.info:
        return _renderImage('assets/icons/info.png');
      case NotificationType.custom:
        return icon ?? const SizedBox.shrink();
    }
  }

  Image _renderImage(String imageAsset) {
    return Image(
      image: AssetImage(
        imageAsset,
        package: 'flutter_toastify',
      ),
      width: iconSize,
    );
  }
}
