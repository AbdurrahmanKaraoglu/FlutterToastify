import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';

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



// Bu kod, bir bildirim içeriği gösteren Flutter Toastify uyarılarını oluşturan `FlutterToastifyContent` adlı bir widget sınıfını tanımlar. Bu widget, bildirimlerin içeriğini oluşturmak için kullanılır ve şu özelliklere sahiptir:

// - `title`: Bildirim başlığını içeren bir Widget (isteğe bağlı).
// - `description`: Bildirim açıklamasını içeren bir Widget (zorunlu).
// - `icon`: Bildirimde gösterilecek simgeyi içeren bir Widget (isteğe bağlı).
// - `iconSize`: Simge boyutunu piksel cinsinden belirten bir değer (varsayılan olarak 20).
// - `notificationType`: Bildirim türünü belirleyen `NotificationType` enum değeri (SUCCESS, ERROR, INFO, CUSTOM).
// - `onCloseButtonPressed`: Kapatma düğmesine basıldığında çağrılacak fonksiyon.
// - `displayCloseButton`: Kapatma düğmesini gösterme veya gizleme durumunu belirleyen bir boolean değer.
// - `closeButton`: Kapatma düğmesi için özel olarak belirtilen bir Widget (isteğe bağlı).
// - `action`: Tıklanabilir mürekkep ile render edilen bir eylem bileşeni (isteğe bağlı).
// - `onActionPressed`: `action` bileşeni için tetikleyici fonksiyon (action != null olduğunda boş olmamalıdır).

// `FlutterToastifyContent` widget'ı, bildirim içeriğini düzenlemek için bir `Row` içinde birkaç alt bileşeni düzenler. Bildirim türüne göre, simge alanı doğru simgeyle değiştirilir ve bildirim içeriği görsel olarak oluşturulur. Aynı zamanda kapatma düğmesi ve opsiyonel eylem bileşeni de bu içeriğe eklenir.

// Genel olarak, bu kod, kullanıcı dostu bildirim içeriklerini oluşturmak için kullanılabilir ve bildirimlerin içeriğini düzenleme sürecini kolaylaştırır.


// This code defines a Flutter widget called `FlutterToastifyContent`, which is used to create the content of Flutter Toastify notifications. The widget is responsible for building the visual representation of the notification content and has the following properties:

// - `title`: A Widget that contains the title of the notification (optional).
// - `description`: A Widget that contains the description of the notification (required).
// - `icon`: A Widget that represents the icon to be displayed in the notification (optional).
// - `iconSize`: A value that determines the size of the icon in pixels (default is 20).
// - `notificationType`: A `NotificationType` enum value that specifies the type of the notification (SUCCESS, ERROR, INFO, CUSTOM).
// - `onCloseButtonPressed`: A function that will be called when the close button is pressed.
// - `displayCloseButton`: A boolean value that determines whether to display the close button or not.
// - `closeButton`: A custom Widget specifically provided for the close button (optional).
// - `action`: A clickable ink renderable action component (optional).
// - `onActionPressed`: A trigger function for the `action` component (should not be empty when `action != null`).

// The `FlutterToastifyContent` widget organizes the notification content within a `Row` with several sub-components. Depending on the notification type, the icon area is replaced with the appropriate icon, and the visual representation of the notification content is built. Additionally, the close button and optional action component are also included in this content.

// In conclusion, this code can be used to create user-friendly notification contents and simplifies the process of composing the content for notifications.