# FlutterToastify

[![pub package](https://img.shields.io/pub/v/flutter_toastify.svg)](https://pub.dev/packages/flutter_toastify)

FlutterToastify, özelleştirilebilir toast benzeri mesajlarla kullanıcı bildirimleri göstermek için kullanılan bir Flutter paketidir. Bu paket, başarı, hata ve bilgi bildirimlerini isteğe bağlı ilerleme göstergeleri ve özel animasyonlarla göstermenizi sağlar.

## Kullanım

1. İlk olarak, projenize `flutter_toastify` paketini ekleyin. `pubspec.yaml` dosyasını aşağıdaki gibi düzenleyin:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_toastify: ^1.0.0
```

2. Daha sonra, paketi projenize eklemek için `flutter pub get` komutunu çalıştırın.

3. İşte bir örnek kod:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterToastify Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FlutterToastify.showToast(
              title: 'Başarılı!',
              description: 'Bu, bir başarı bildirimidir.',
              type: FlutterToastifyType.success,
              showProgressIndicator: true,
              autoDismiss: true,
            );
          },
          child: Text('Bildirim Göster'),
        ),
      ),
    );
  }
}
```

Bu örnekte, `FlutterToastify.showToast` fonksiyonu, başarı bildirimi göstermek için kullanılmıştır. Bildirimde ilerleme göstergesi ve otomatik kapanma özelliği bulunmaktadır.

## Özellikler

- `FlutterToastify` Sınıfı:

```dart
class FlutterToastify {
  FlutterToastify._(); // Özel yapılandırıcı

  static void showToast({
    String? title,
    required String description,
    FlutterToastifyType type = FlutterToastifyType.custom,
    bool showProgressIndicator = true,
    Duration duration = const Duration(milliseconds: 3000),
    bool autoDismiss = true,
    Function()? onCloseButtonPressed,
  }) {
    // Verilen yapılandırmalarla bildirim gösterilir.
  }
}
```

- `title`: Bildirim başlığı. Varsayılan olarak `null` ve görüntülenmez.
- `description`: Bildirim açıklama metni (zorunlu).
- `type`: Bildirim tipi (`FlutterToastifyType` enumundan). Varsayılan değer `FlutterToastifyType.custom`.
- `showProgressIndicator`: Bildirimde ilerleme göstergesi gösterilsin mi? Varsayılan değer `true`.
- `duration`: Bildirimin gösterileceği süre. Varsayılan değer `Duration(milliseconds: 3000)` (3 saniye).
- `autoDismiss`: Bildirimin belirtilen süre sonra otomatik olarak kapanıp kapanmayacağını belirtir. Varsayılan değer `true`.
- `onCloseButtonPressed`: Bildirimin kapatma düğmesine basıldığında çağrılacak geri çağırma fonksiyonu.

## Stil

`FlutterToastifyStyle` sınıfı, özel renkler ve stiller için statik özellikler sağlar:

```dart
class FlutterToastifyStyle {
  static Color get successColor => Color(0xff01CB67);
  static Color get errorColor => Color(0xffFE355C);
  static Color get infoColor => Color(0xff0066FF);
  static Color get defaultColor => Colors.blue;

  static EdgeInsetsGeometry get contentPadding =>
      EdgeInsets.symmetric(horizontal: 24, vertical: 20);

  static double get iconSize => 20.0;
}
```

## Lisans

Bu proje MIT Lisansı altında lisanslanmıştır. Daha fazla bilgi için [LICENSE](https://pub.dev/packages/flutter_toastify/license) dosyasını inceleyebilirsiniz.

# FlutterToastify

[![pub package](https://img.shields.io/pub/v/flutter_toastify.svg)](https://pub.dev/packages/flutter_toastify)

FlutterToastify is a Flutter package used to display user notifications with customizable toast-like messages. This package provides an easy way to show success, error, and info notifications with optional progress indicators and custom animation.

## Usage

1. First, add the `flutter_toastify` package to your project. Edit the `pubspec.yaml` file as follows:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_toastify: ^1.0.0
```

2. Next, run `flutter pub get` to fetch the package.

3. Here's an example code:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_toastify/flutter_toastify.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterToastify Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FlutterToastify.showToast(
              title: 'Success!',
              description: 'This is a success notification.',
              type: FlutterToastifyType.success,
              showProgressIndicator: true,
              autoDismiss: true,
            );
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
```

In this example, `FlutterToastify.showToast` function is used to show a success notification with a progress indicator and auto-dismiss feature.

## Features

- `FlutterToastify` Class:

```dart
class FlutterToastify {
  FlutterToastify._(); // Private constructor

  static void showToast({
    String? title,
    required String description,
    FlutterToastifyType type = FlutterToastifyType.custom,
    bool showProgressIndicator = true,
    Duration duration = const Duration(milliseconds: 3000),
    bool autoDismiss = true,
    Function()? onCloseButtonPressed,
  }) {
    // Show notification with provided configurations.
  }
}
```

- `title`: The title of the notification. By default, it's `null` and won't be displayed.
- `description`: The description text of the notification (required).
- `type`: The type of notification (from `FlutterToastifyType` enum). The default value is `FlutterToastifyType.custom`.
- `showProgressIndicator`: Specifies whether to show a progress indicator in the notification. The default value is `true`.
- `duration`: The duration for which the notification will be displayed. The default value is `Duration(milliseconds: 3000)` (3 seconds).
- `autoDismiss`: Specifies whether the notification will automatically dismiss after the specified duration. The default value is `true`.
- `onCloseButtonPressed`: A callback function that will be called when the notification's close button is pressed.

## Styling

The `FlutterToastifyStyle` class provides static properties for custom colors and styles:

```dart
class FlutterToastifyStyle {
  static Color get successColor => Color(0xff01CB67);
  static Color get errorColor => Color(0xffFE355C);
  static Color get infoColor => Color(0xff0066FF);
  static Color get defaultColor => Colors.blue;

  static EdgeInsetsGeometry get contentPadding =>
      EdgeInsets.symmetric(horizontal: 24, vertical: 20);

  static double get iconSize => 20.0;
}
```

## License

This project is licensed under the MIT License. For more information, see the [LICENSE](https://pub.dev/packages/flutter_toastify/license) file.