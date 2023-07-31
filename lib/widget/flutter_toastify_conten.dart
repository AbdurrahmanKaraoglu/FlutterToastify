import 'package:flutter/material.dart';
import 'package:flutter_toastify/resources/constants.dart';
import 'package:flutter_toastify/resources/enums.dart';

class FlutterToastifyContent extends StatelessWidget {
  const FlutterToastifyContent({
    Key? key,
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
  }) : super(key: key);

  /// Eğer varsa, bildirim başlığı
  final Widget? title;

  /// Bildirim açıklaması
  final Widget description;

  /// Bildirim simgesi
  final Widget? icon;

  /// Simge boyutu (piksel cinsinden)
  final double iconSize;

  /// Bildirim tipi, her bir yapılandırmada otomatik olarak ayarlanacaktır
  /// Mümkün değerler:
  ///```dart
  ///{
  ///SUCCESS,
  ///ERROR,
  ///INFO,
  ///CUSTOM
  ///}
  ///```
  final NotificationType notificationType;

  /// Kapatma düğmesine basıldığında çağrılacak fonksiyon
  final void Function() onCloseButtonPressed;

  /// Kapatma düğmesi bileşenini gösterme veya gizleme
  final bool displayCloseButton;

  /// Kapatma düğmesi bileşeni, varsayılan olarak `action == null`
  final Widget Function(void Function() dismissNotification)? closeButton;

  /// Tıklanabilir mürekkep ile render edilen eylem bileşeni
  /// varsayılan olarak `action == null`
  final Widget? action;

  /// `action` bileşenine basıldığında çağrılacak fonksiyon
  /// `action != null` olduğunda boş olmamalıdır
  final Function()? onActionPressed;

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

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
        Visibility(
          visible: displayCloseButton,
          child: closeButton?.call(onCloseButtonPressed) ??
              InkWell(
                onTap: () {
                  onCloseButtonPressed.call();
                },
                child: Padding(
                  padding: isRtl
                      ? const EdgeInsets.only(
                          top: AppConstants.verticalPadding,
                          left: AppConstants.horizontalPadding,
                        )
                      : const EdgeInsets.only(
                          top: AppConstants.verticalPadding,
                          right: AppConstants.horizontalPadding,
                        ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
        )
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
      default:
        return icon!;
    }
  }

  Image _renderImage(String imageAsset) {
    return Image(
      image: AssetImage(
        imageAsset,
        package: "flutter_toastify",
      ),
      width: iconSize,
    );
  }
}

//   AssetGenImage get error => const AssetGenImage('assets/icons/error.png');

//   /// File path: assets/icons/info.png
//   AssetGenImage get info => const AssetGenImage('assets/icons/info.png');

//   /// File path: assets/icons/success.png
//   AssetGenImage get success => const AssetGenImage('assets/icons/success.png');
