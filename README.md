## flutter_toastify

[![pub package](https://img.shields.io/pub/v/flutter_toastify.svg)](https://pub.dev/packages/flutter_toastify)

FlutterToastify, kullanıcılara animasyonlu üst bildirimler (SnackBar) gösterme işlevselliği sağlayan basit bir Flutter paketidir.

## Özellikler

- `message`: Bildirimde gösterilecek mesajı belirtir. (zorunlu)
- `position`: Bildirimin konumunu belirtir. Varsayılan olarak üst orta.
- `backgroundColor`: Bildirim arkaplan rengini belirtir. Varsayılan olarak beyaz.
- `textColor`: Bildirim metin rengini belirtir. Varsayılan olarak siyah.
- `fontSize`: Bildirim metin boyutunu belirtir. Varsayılan olarak 16.
- `duration`: Bildirimin ekranda kalma süresini belirtir. Varsayılan olarak 2 saniye.
- `animation`: Bildirimin açılma animasyon türünü belirtir. Varsayılan olarak yukarıdan aşağıya.

## Kullanım

Paketi kullanmak için, projenizin `pubspec.yaml` dosyasına aşağıdaki satırı ekleyin:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_toastify: ^1.0.0 # (paket versiyon numarası)
```

Sonra, FlutterToastify paketini uygulama kodunuzda kullanabilirsiniz. Aşağıda bir örnek kullanım gösterilmiştir:

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
      home: Scaffold(
        appBar: AppBar(title: Text('FlutterToastify Örneği')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              FlutterToastify(
                message: 'Merhaba, FlutterToastify ile bildirim gösteriyorum!',
                position: NotificationPosition.topCenter,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 18.0,
                duration: Duration(seconds: 3),
                animation: AnimationType.fromTop,
              ).show(context);
            },
            child: Text('Bildirim Göster'),
          ),
        ),
      ),
    );
  }
}
```

Bu örnek, kullanıcı düğmeye tıkladığında üstte mavi bir bildirim gösterecektir.

## Lisans

Bu proje MIT Lisansı altında lisanslanmıştır. Daha fazla bilgi için [LICENSE](https://pub.dev/packages/flutter_toastify/license) dosyasını inceleyebilirsiniz.