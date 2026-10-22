# FlutterToastify

[![pub package](https://img.shields.io/pub/v/flutter_toastify.svg)](https://pub.dev/packages/flutter_toastify)
[![pub points](https://img.shields.io/pub/points/flutter_toastify)](https://pub.dev/packages/flutter_toastify/score)
[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**EN** · Animated toast notifications for Flutter with success, error, info and custom styles,
an optional progress bar, action links and custom close buttons. No dependencies.

**TR** · Flutter için başarı, hata, bilgi ve özel stillerde, ilerleme çubuklu, eylem bağlantılı
ve özel kapatma düğmeli animasyonlu toast bildirimleri. Bağımlılığı yoktur.

| Success | Error | Custom | Action |
|:---:|:---:|:---:|:---:|
| <img src="https://raw.githubusercontent.com/AbdurrahmanKaraoglu/FlutterToastify/main/doc/screenshots/success.webp" width="180" alt="Success toast"> | <img src="https://raw.githubusercontent.com/AbdurrahmanKaraoglu/FlutterToastify/main/doc/screenshots/error.webp" width="180" alt="Error toast"> | <img src="https://raw.githubusercontent.com/AbdurrahmanKaraoglu/FlutterToastify/main/doc/screenshots/custom.webp" width="180" alt="Custom toast"> | <img src="https://raw.githubusercontent.com/AbdurrahmanKaraoglu/FlutterToastify/main/doc/screenshots/action.webp" width="180" alt="Toast with an action link"> |

## Features / Özellikler

- Built-in `success`, `error` and `info` styles, or your own icon and colors. /
  Hazır stiller ya da kendi ikonunuz ve renkleriniz.
- 9 positions and 4 slide directions. / 9 konum ve 4 kayma yönü.
- Remaining time progress bar, auto dismiss or persistent toasts. /
  Kalan süre çubuğu, kendiliğinden kapanan ya da kalıcı bildirimler.
- Action link and custom close button. / Eylem bağlantısı ve özel kapatma düğmesi.
- Works in `MaterialApp` and `CupertinoApp`; shown on the root overlay, so it stays visible
  across route changes. / `MaterialApp` ve `CupertinoApp` ile çalışır; kök overlay'da gösterilir.
- Accessible: announced as a live region, 48x48 close button with a localized label, RTL aware. /
  Erişilebilir: canlı bölge olarak okunur, 48x48 etiketli kapatma düğmesi, RTL desteği.

## Installation / Kurulum

```yaml
dependencies:
  flutter_toastify: ^2.0.4
```

Requirements / Gereksinim: Dart 3.6+, Flutter 3.27+.

## Usage / Kullanım

```dart
import 'package:flutter/material.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

ElevatedButton(
  onPressed: () {
    FlutterToastify.success(
      width: 360,
      notificationPosition: NotificationPosition.topLeft,
      animation: AnimationType.fromTop,
      title: const Text('Update'),
      description: const Text('Your data has been updated'),
    ).show(context);
  },
  child: const Text('Show'),
);
```

Built-in styles / Hazır stiller: `FlutterToastify.success`, `FlutterToastify.error`,
`FlutterToastify.info`. With your own icon and colors / Kendi ikonunuz ve renklerinizle:

```dart
FlutterToastify(
  icon: const Icon(Icons.access_alarm, color: Colors.orange),
  description: const Text('A new version is available'),
  progressIndicatorColor: Colors.orange,
  notificationPosition: NotificationPosition.bottomRight,
  animation: AnimationType.fromBottom,
).show(context);
```

Persistent toast with a custom close button / Kalıcı bildirim ve özel kapatma düğmesi:

```dart
final toast = FlutterToastify(
  icon: const Icon(Icons.dashboard_customize_outlined),
  description: const Text('You can now go to the dashboard'),
  autoDismiss: false,
  showProgressIndicator: false, // required when autoDismiss is false
  closeButton: (dismiss) => IconButton(onPressed: dismiss, icon: const Icon(Icons.logout)),
);
toast.show(context);
// To close it from code / Kodla kapatmak için:
toast.closeOverlay();
```

The [example app](example/lib/main.dart) shows every scenario in English and Turkish. /
[Örnek uygulama](example/lib/main.dart) tüm senaryoları İngilizce ve Türkçe gösterir.

## Parameters / Parametreler

| Parameter | Default / Varsayılan | Description / Açıklama |
|---|---|---|
| `title` | `null` | Title widget / Başlık |
| `description` | required / zorunlu | Main content / Ana içerik |
| `icon` | required (custom) | Custom constructor only / Yalnızca `FlutterToastify()` |
| `notificationPosition` | `topRight` | `center`, `centerLeft`, `centerRight`, `topLeft`, `topCenter`, `topRight`, `bottomLeft`, `bottomCenter`, `bottomRight` |
| `animation` | `fromRight` | `fromLeft`, `fromRight`, `fromTop`, `fromBottom` (must match the position / konumla uyumlu olmalı) |
| `animationDuration` | 600 ms | Slide in/out duration / Giriş-çıkış süresi |
| `toastDuration` | 3000 ms | Display duration / Ekranda kalma süresi |
| `autoDismiss` | `true` | Close after `toastDuration` / Süre sonunda kapanır |
| `showProgressIndicator` | `true` | Progress bar, requires `autoDismiss` / İlerleme çubuğu |
| `displayCloseButton` | `true` | Show the close button / Kapatma düğmesini göster |
| `closeButton` | `null` | `(dismiss) => Widget` custom close button / Özel kapatma düğmesi |
| `action`, `onActionPressed` | `null` | Tappable action; `onActionPressed` required with `action` / Tıklanabilir eylem |
| `width`, `height` | 70% / at least 12% of screen | Size; grows with content when `height` is null / Boyut |
| `background`, `progressIndicatorColor`, `progressIndicatorBackground` | white / style / grey | Colors / Renkler |
| `onProgressFinished` | `null` | Called on auto dismiss / Süre dolunca |
| `onCloseButtonPressed`, `onDismiss` | `null` | Called when the close button is pressed / Kapatma düğmesine basılınca |

Custom constructor only / Yalnızca özel kurucu: `shadowColor`, `radius`, `enableShadow`.

## Migrating to 2.0.0 / 2.0.0'a geçiş

- Enums are exported from the main library; you can drop
  `package:flutter_toastify/components/enums.dart`. / Enum'lar ana kütüphaneden gelir.
- Use `widget/flutter_toastify_content.dart` instead of the misspelled
  `widget/flutter_toastify_conten.dart`. / Düzeltilmiş dosya adını kullanın.
- Fields are `final`; pass values to the constructor. / Alanlar `final`; değerleri kurucuya verin.

## Other packages / Diğer paketler

By the same publisher, [abdurrahmankaraoglu.com](https://pub.dev/publishers/abdurrahmankaraoglu.com/packages):

| Package | Description / Açıklama |
|---|---|
| [turkish_kit](https://pub.dev/packages/turkish_kit) | Turkish validators (TC kimlik, VKN, IBAN, phone), amounts in words and text helpers / Türkçe doğrulayıcılar ve metin araçları |
| [google_maps_polyline](https://pub.dev/packages/google_maps_polyline) | Routes and polylines from the Google Directions API / Google Directions ile rota ve polyline |
| [marker_crafter](https://pub.dev/packages/marker_crafter) | Custom Google Maps markers drawn with Canvas / Canvas ile özel harita işaretçileri |
| [animated_route_marker](https://pub.dev/packages/animated_route_marker) | Smoothly moving markers along a route or live GPS / Rota boyunca akıcı hareket eden işaretçi |
| [advanced_background_locator](https://pub.dev/packages/advanced_background_locator) | Background location tracking / Arka planda konum takibi |
| [advanced_geofence](https://pub.dev/packages/advanced_geofence) | Enter, exit and dwell events for circle and polygon zones / Daire ve çokgen bölge olayları |
| [route_simulator](https://pub.dev/packages/route_simulator) | Realistic fake GPS streams along a route / Rota boyunca gerçekçi sahte GPS akışı |

## License / Lisans

MIT, see / bkz. [LICENSE](LICENSE).
