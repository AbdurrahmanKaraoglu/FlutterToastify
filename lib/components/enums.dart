/// Enums used across the package. / Paket genelinde kullanılan enum'lar.
library;

/// Style of a notification. / Bildirimin türü.
enum NotificationType {
  /// Success notification type. / Başarılı durum bildirim türü.
  success,

  /// Error notification type. / Hata durumu bildirim türü.
  error,

  /// Information notification type. / Bilgi amaçlı bildirim türü.
  info,

  /// Custom notification type. / Özel bildirim türü.
  custom,
}

/// Side a notification slides in from. / Bildirimin kayarak geldiği yön.
enum AnimationType {
  /// Animation type from the left. / Soldan gelen animasyon türü.
  fromLeft,

  /// Animation type from the right. / Sağdan gelen animasyon türü.
  fromRight,

  /// Animation type from the top. / Yukarıdan gelen animasyon türü.
  fromTop,

  /// Animation type from the bottom. / Aşağıdan gelen animasyon türü.
  fromBottom,
}

/// Where a notification appears on screen. / Bildirimin ekrandaki konumu.
enum NotificationPosition {
  /// Centered notification. / Ortada konumlanan bildirim.
  center,

  /// Notification positioned at the center-right. / Sağ ortada konumlanan bildirim.
  centerRight,

  /// Notification positioned at the center-left. / Sol ortada konumlanan bildirim.
  centerLeft,

  /// Notification positioned at the top-center. / Üst ortada konumlanan bildirim.
  topCenter,

  /// Notification positioned at the top-right. / Sağ üstte konumlanan bildirim.
  topRight,

  /// Notification positioned at the top-left. / Sol üstte konumlanan bildirim.
  topLeft,

  /// Notification positioned at the bottom-center. / Alt ortada konumlanan bildirim.
  bottomCenter,

  /// Notification positioned at the bottom-right. / Sağ altta konumlanan bildirim.
  bottomRight,

  /// Notification positioned at the bottom-left. / Sol altta konumlanan bildirim.
  bottomLeft,
}
