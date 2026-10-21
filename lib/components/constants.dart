import 'package:flutter/material.dart';

/// Default sizes and colors used by the package.
///
/// Paketin kullandığı varsayılan boyutlar ve renkler.
class AppConstants {
  /// Default padding. / Varsayılan dolgu boşluğu.
  static const double defaultPadding = 16.0;

  /// Default vertical padding. / Varsayılan dikey dolgu boşluğu.
  static const double verticalPadding = 20.0;

  /// Default size of the built-in style icons. / Hazır stil ikonlarının varsayılan boyutu.
  static const double defaultIconSize = 20.0;

  /// Default horizontal padding. / Varsayılan yatay dolgu boşluğu.
  static const double horizontalPadding = 10.0;

  /// Reference width for toast messages. / Bildirimler için başvuru genişliği.
  static const double toastWidth = 400;

  /// Minimum tap target size for accessibility (Material guideline).
  ///
  /// Erişilebilirlik için en küçük dokunma alanı (Material yönergesi).
  static const double minTapTargetSize = 48.0;

  /// Top and bottom padding of the text when no height is given.
  ///
  /// Yükseklik verilmediğinde bildirim metninin üst ve alt boşluğu.
  static const double contentVerticalPadding = 12.0;

  /// Color of the info style. / Bilgi stilinin rengi.
  static const Color infoColor = Color(0xff0066FF);

  /// Misspelled old name; use [infoColor] instead.
  ///
  /// Eski, yazım hatalı ad; yerine [infoColor] kullanın.
  @Deprecated('Use AppConstants.infoColor instead.')
  static const Color inforColor = infoColor;

  /// Color of the success style. / Başarı stilinin rengi.
  static const Color successColor = Color(0xff01CB67);

  /// Color of the error style. / Hata stilinin rengi.
  static const Color errorColor = Color(0xffFE355C);

  /// Light grey used for the divider and progress bar track.
  ///
  /// Ayraç ve ilerleme çubuğu arka planı için açık gri.
  static const Color greyColor = Color(0xffF3F3F3);
}
