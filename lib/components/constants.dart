import 'package:flutter/material.dart';

/// Bu sınıf, uygulama boyunca kullanılacak genel sabit değerleri içerir.
/// This class contains general constant values to be used throughout the app.

class AppConstants {
  /// Genel Stil Ayarları
  /// General Style Settings

  /// Varsayılan dolgu boşluğu (padding) değeri.
  /// Default padding value used for spacing elements.

  static const double defaultPadding = 16.0;

  /// Dikey yönde dolgu boşluğu (padding) değeri.
  /// Vertical padding value used for spacing elements vertically.

  static const double verticalPadding = 20.0;

  /// Simge (icon) boyutu için varsayılan değer.
  /// Default icon size value.

  static const double defaultIconSize = 20.0;

  /// Yatay yönde dolgu boşluğu (padding) değeri.
  /// Horizontal padding value used for spacing elements horizontally.

  static const double horizontalPadding = 10.0;

  /// Bildirim mesajları için kullanılacak genişlik değeri.
  /// Width value for the toast messages.

  static const double toastWidth = 400;

  /// Erişilebilirlik için en küçük dokunma alanı (Material yönergesi).
  /// Minimum tap target size for accessibility (Material guideline).
  static const double minTapTargetSize = 48.0;

  /// Renkler
  /// Colors

  /// Bilgi mesajlarında kullanılacak renk.
  /// Color used for informational messages.

  static const Color infoColor = Color(0xff0066FF);

  /// Eski, yazım hatalı ad; yerine [infoColor] kullanın.
  @Deprecated('Use AppConstants.infoColor instead.')
  static const Color inforColor = infoColor;

  /// Başarılı işlemlerde kullanılacak renk.
  /// Color used for successful operations or messages.

  static const Color successColor = Color(0xff01CB67);

  /// Hata durumlarında kullanılacak renk.
  /// Color used for error situations or messages.

  static const Color errorColor = Color(0xffFE355C);

  /// Gri renkteki arka plan rengi.
  /// Color used for the grey background.

  static const Color greyColor = Color(0xffF3F3F3);
}
