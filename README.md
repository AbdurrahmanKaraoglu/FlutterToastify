# FlutterToastify

[![pub package](https://img.shields.io/pub/v/flutter_toastify.svg)](https://pub.dev/packages/flutter_toastify)

**TR** · FlutterToastify; başarı, hata, bilgi ve özel stillerde, ilerleme çubuklu ve animasyonlu
toast bildirimleri göstermek için bir Flutter paketidir.

**EN** · FlutterToastify is a Flutter package for animated toast notifications with success,
error, info and custom styles, an optional progress bar and action support.

## Kurulum / Installation

```yaml
dependencies:
  flutter_toastify: ^2.0.2
```

Gereksinim / Requirements: Dart 3.6+, Flutter 3.27+.

## Kullanım / Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

ElevatedButton(
  onPressed: () {
    FlutterToastify.success(
      width: 360,
      notificationPosition: NotificationPosition.topLeft,
      animation: AnimationType.fromTop,
      title: const Text('Güncelleme / Update'),
      description: const Text('Verileriniz güncellendi / Your data has been updated'),
    ).show(context);
  },
  child: const Text('Bildirim göster / Show'),
);
```

Hazır stiller / Built-in styles: `FlutterToastify.success`, `FlutterToastify.error`,
`FlutterToastify.info`. Kendi ikonunuz ve renklerinizle / With your own icon and colors:

```dart
FlutterToastify(
  icon: const Icon(Icons.access_alarm, color: Colors.orange),
  description: const Text('Yeni sürüm mevcut / A new version is available'),
  progressIndicatorColor: Colors.orange,
  notificationPosition: NotificationPosition.bottomRight,
  animation: AnimationType.fromBottom,
).show(context);
```

Kalıcı bildirim ve özel kapatma düğmesi / Persistent toast with a custom close button:

```dart
final toast = FlutterToastify(
  icon: const Icon(Icons.dashboard_customize_outlined),
  description: const Text('Panele geçebilirsiniz / You can go to the dashboard'),
  autoDismiss: false,
  showProgressIndicator: false, // autoDismiss: false ise zorunlu / required
  closeButton: (dismiss) => IconButton(onPressed: dismiss, icon: const Icon(Icons.logout)),
);
toast.show(context);
// Kodla kapatmak için / To close programmatically:
toast.closeOverlay();
```

## Parametreler / Parameters

| Parametre | Varsayılan / Default | Açıklama / Description |
|---|---|---|
| `title` | `null` | Başlık widget'ı / Title widget |
| `description` | zorunlu / required | Açıklama widget'ı / Description widget |
| `icon` | zorunlu (özel) / required (custom) | Yalnızca `FlutterToastify()` için / Custom constructor only |
| `notificationPosition` | `topRight` | `center`, `centerLeft`, `centerRight`, `topLeft`, `topCenter`, `topRight`, `bottomLeft`, `bottomCenter`, `bottomRight` |
| `animation` | `fromRight` | `fromLeft`, `fromRight`, `fromTop`, `fromBottom` (konumla uyumlu olmalı / must match the position) |
| `animationDuration` | 600 ms | Giriş/çıkış animasyonu / Slide in/out duration |
| `toastDuration` | 3000 ms | Ekranda kalma süresi / Display duration |
| `autoDismiss` | `true` | Süre sonunda kendiliğinden kapanır / Auto close after `toastDuration` |
| `showProgressIndicator` | `true` | İlerleme çubuğu (`autoDismiss` gerekir) / Progress bar (requires `autoDismiss`) |
| `displayCloseButton` | `true` | Kapatma düğmesini göster / Show the close button |
| `closeButton` | `null` | `(dismiss) => Widget` özel kapatma düğmesi / Custom close button builder |
| `action`, `onActionPressed` | `null` | Tıklanabilir eylem; `action` verilirse `onActionPressed` zorunlu / Tappable action |
| `width`, `height` | ekranın %70'i / en az %12'si | Boyut; `height` verilmezse içeriğe göre büyür / Size; grows with content when `height` is null |
| `background`, `progressIndicatorColor`, `progressIndicatorBackground` | beyaz / stile göre / gri | Renkler / Colors |
| `onProgressFinished` | `null` | Süre dolup kapandığında / Called on auto dismiss |
| `onCloseButtonPressed`, `onDismiss` | `null` | Kapatma düğmesine basıldığında / Called when the close button is pressed |

Özel kurucuya özgü / Custom constructor only: `shadowColor`, `radius`, `enableShadow`.

## 2.0.0'a geçiş / Migrating to 2.0.0

- Enum'lar ana kütüphaneden gelir; `package:flutter_toastify/components/enums.dart` importunu
  kaldırabilirsiniz. / Enums are exported from the main library.
- `package:flutter_toastify/widget/flutter_toastify_conten.dart` yerine
  `flutter_toastify_content.dart` kullanın. / Use the corrected file name.
- Widget alanlarına sonradan değer atanamaz; değerleri kurucuya verin. / Fields are now `final`.

## Lisans / License

MIT — bkz. / see [LICENSE](LICENSE).
