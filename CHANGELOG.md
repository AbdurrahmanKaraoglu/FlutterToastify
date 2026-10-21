## 2.0.3

* DOCS: API documentation is now in English first, followed by Turkish. /
  API belgeleri artık önce İngilizce, ardından Türkçe.
* DOCS: The changelog is bilingual. / Değişiklik günlüğü iki dilli oldu.
* EXAMPLE: The example app supports English and Turkish, follows the device language and has a
  language picker. / Örnek uygulama İngilizce ve Türkçe destekliyor, cihaz dilini izliyor ve
  dil seçicisi var.
* No code changes in the package. / Paket kodunda değişiklik yok.

## 2.0.2

* FIX: Without a `height`, multi-line content (e.g. title + description + `action`) touched the
  top and bottom edges; the text now has 12 px vertical padding. Layout with a fixed `height` is
  unchanged. / `height` verilmediğinde çok satırlı içerik kenarlara yapışıyordu; metne 12 px
  dikey boşluk eklendi. Sabit `height` ile yerleşim değişmedi.

## 2.0.1

* FIX: `show()` crashed with "No MaterialLocalizations found" on iOS/macOS in apps without Material
  localizations, such as `CupertinoApp`. The notification no longer uses `AlertDialog`, is not
  affected by the app's `DialogTheme` and is announced as a live region instead of a dialog. /
  `CupertinoApp` gibi uygulamalarda iOS/macOS'ta `show()` çöküyordu. Bildirim artık
  `AlertDialog` kullanmıyor, `DialogTheme`'den etkilenmiyor ve ekran okuyucuya diyalog olarak
  bildirilmiyor.
* FIX: If the overlay was destroyed before the notification (e.g. the app tree changed),
  `isShowing` stayed `true` and the same notification could not be shown again. /
  Overlay bildirimden önce yok edilirse `isShowing` `true` kalıyor, bildirim bir daha
  gösterilemiyordu.
* FIX: The default close button is at least 48x48 and has a screen reader label. /
  Varsayılan kapatma düğmesi en az 48x48 ve ekran okuyucu etiketli.
* FIX: The progress bar moves linearly with time (it used to slow down at both ends). /
  İlerleme çubuğu süreyle doğrusal ilerliyor.
* `onCloseButtonPressed`, `onProgressFinished`, `onActionPressed` and `onDismiss` are now
  `VoidCallback?`. / Bu geri çağrıların tipi `VoidCallback?` oldu.
* Added `AppConstants.infoColor`; the misspelled `inforColor` and the unused
  `AnimatedProgressBar.value` are deprecated. / `infoColor` eklendi; `inforColor` ve
  `AnimatedProgressBar.value` kullanımdan kalktı.

## 2.0.0

**Breaking changes / Kırıcı değişiklikler**

* Requires Dart 3.6 / Flutter 3.27. / Dart 3.6 / Flutter 3.27 gerekir.
* `FlutterToastify` is now immutable: `icon`, `background`, `shadowColor`, `radius`,
  `enableShadow`, `showProgressIndicator`, `progressIndicatorColor` and `notificationType` are
  `final`, and `overlayEntry` is read-only. / `FlutterToastify` artık değişmez; bu alanlar
  `final`, `overlayEntry` salt okunur.
* `FlutterToastifyState.closeTimer` is now `Timer?` (`null` when `autoDismiss` is false). /
  `closeTimer` artık `Timer?`.

**Fixes / Düzeltmeler**

* Calling `show()` twice on the same instance leaked the previous `OverlayEntry`; the second
  call is now ignored and removed entries are disposed. / Aynı örnekte iki kez `show()`
  çağrılınca `OverlayEntry` sızıyordu.
* `closeOverlay()` threw after `show()` when there was no `Overlay`. / `Overlay` yokken
  `closeOverlay()` hata veriyordu.
* The close button removed the notification without the slide out animation, and a double tap
  fired the callbacks twice. / Kapatma düğmesi animasyonsuz kapatıyor, çift dokunuş geri
  çağrıları iki kez tetikliyordu.
* Long descriptions overflowed when no `height` was given; the height is now at least 12% of the
  screen and grows with the content. / `height` verilmediğinde uzun metin taşıyordu.
* A custom notification without `icon` crashed with a null error. / `icon` verilmeyen özel
  bildirim çöküyordu.
* Replaced the deprecated `Color.withOpacity` with `withValues`. / Kullanımdan kalkmış
  `withOpacity` yerine `withValues` kullanıldı.

**New / Yenilikler**

* `NotificationPosition`, `AnimationType` and `NotificationType` are exported from
  `package:flutter_toastify/flutter_toastify.dart`. / Enum'lar ana kütüphaneden dışa aktarılıyor.
* Added the `isShowing` getter. / `isShowing` eklendi.
* Renamed `widget/flutter_toastify_conten.dart` to `flutter_toastify_content.dart`; the old path
  is deprecated but still works. / Dosya adındaki yazım hatası düzeltildi, eski yol çalışıyor.
* Removed platform folders accidentally added to the package root, recreated the example app
  and added tests. / Kökteki gereksiz platform klasörleri kaldırıldı, örnek yenilendi, testler
  eklendi.

## 1.0.4

* FIX: Minor bug fixes. / Bazı basit hata düzeltmeleri.

## 1.0.3

* FIX: Minor bug fixes. / Bazı basit hata düzeltmeleri.

## 1.0.2

* FIX: Bug fixes. / Bazı hata düzeltmeleri.

## 1.0.1

* FIX: Performance improvements. / Performans iyileştirmeleri.

## 1.0.0

* NEW: New features. / Yeni özellikler.

## 0.0.3

* FIX: Bug fixes. / Bazı hata düzeltmeleri.

## 0.0.2

* FIX: Fixes. / Düzeltmeler.

## 0.0.1

* Initial release. / İlk sürüm.
