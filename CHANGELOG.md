## 2.0.0

**Kırıcı değişiklikler / Breaking changes**

* Minimum Dart 3.6 / Flutter 3.27 gerekir.
* `FlutterToastify` artık değişmez (immutable) bir widget: `icon`, `background`, `shadowColor`,
  `radius`, `enableShadow`, `showProgressIndicator`, `progressIndicatorColor` ve
  `notificationType` alanları `final`; dışarıdan atanamaz. `overlayEntry` yalnızca okunabilir.
* `FlutterToastifyState.closeTimer` artık `Timer?` (`autoDismiss: false` iken `null`).

**Düzeltmeler / Fixes**

* Aynı bildirim örneğine `show()` iki kez çağrıldığında önceki `OverlayEntry` sızıyordu; artık
  ikinci çağrı yok sayılır. Kaldırılan `OverlayEntry` artık `dispose` edilir.
* Bağlamda `Overlay` yokken `show()` sonrası `closeOverlay()` çağrısı hata veriyordu.
* Kapatma düğmesi çıkış animasyonunu oynatmadan bildirimi kaldırıyordu; artık animasyonla kapanır
  ve çift dokunuş geri çağrıları iki kez tetiklemez.
* `height` verilmediğinde uzun açıklama metni taşıyordu (RenderFlex overflow); yükseklik artık
  ekranın en az %12'si olup içeriğe göre büyür.
* `icon` verilmemiş özel bildirim `null` hatasıyla çöküyordu.
* Kullanımdan kalkmış `Color.withOpacity` yerine `withValues` kullanıldı.

**Yenilikler / New**

* `NotificationPosition`, `AnimationType` ve `NotificationType` artık
  `package:flutter_toastify/flutter_toastify.dart` içinden dışa aktarılıyor.
* `isShowing` getter'ı eklendi.
* `widget/flutter_toastify_conten.dart` dosya adı `flutter_toastify_content.dart` olarak düzeltildi;
  eski yol kullanımdan kalktı (deprecated) ama çalışmaya devam ediyor.
* Paket köküne yanlışlıkla eklenmiş platform klasörleri kaldırıldı, örnek uygulama güncel Flutter
  şablonuyla yenilendi, testler eklendi.

## 1.0.4
* FIX: Bazı basit hata düzeltmeleri.
## 1.0.3
* FIX: Bazı basit hata düzeltmeleri.
## 1.0.2

* FIX: Bazı hata düzeltmeleri.

## 1.0.1

* FIX: Performans iyileştirmeleri.

## 1.0.0

* NEW: Yeni özellik eklendi.

## 0.0.3

* FIX: Bazı hata düzeltmeleri.

## 0.0.2

* FIX: Düzeltmeler yapıldı.

## 0.0.1

* TODO: İlk uygulama yayınlama.
