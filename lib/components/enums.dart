/// enums.dart

/// Bildirim türlerini tanımlayan enum.
enum NotificationType {
  /// Başarılı durum bildirim türü. (Success notification type)
  success,

  /// Hata durumu bildirim türü. (Error notification type)
  error,

  /// Bilgi amaçlı bildirim türü. (Information notification type)
  info,

  /// Özel bildirim türü. (Custom notification type)
  custom,
}

/// Animasyon türlerini tanımlayan enum.
enum AnimationType {
  /// Soldan gelen animasyon türü. (Animation type from the left)
  fromLeft,

  /// Sağdan gelen animasyon türü. (Animation type from the right)
  fromRight,

  /// Yukarıdan gelen animasyon türü. (Animation type from the top)
  fromTop,

  /// Aşağıdan gelen animasyon türü. (Animation type from the bottom)
  fromBottom,
}

/// Bildirim konumlarını tanımlayan enum.
enum NotificationPosition {
  /// Ortada konumlanan bildirim. (Centered notification)
  center,

  /// Sağ ortada konumlanan bildirim. (Notification positioned at the center-right)
  centerRight,

  /// Sol ortada konumlanan bildirim. (Notification positioned at the center-left)
  centerLeft,

  /// Üst ortada konumlanan bildirim. (Notification positioned at the top-center)
  topCenter,

  /// Sağ üstte konumlanan bildirim. (Notification positioned at the top-right)
  topRight,

  /// Sol üstte konumlanan bildirim. (Notification positioned at the top-left)
  topLeft,

  /// Alt ortada konumlanan bildirim. (Notification positioned at the bottom-center)
  bottomCenter,

  /// Sağ altta konumlanan bildirim. (Notification positioned at the bottom-right)
  bottomRight,

  /// Sol altta konumlanan bildirim. (Notification positioned at the bottom-left)
  bottomLeft,
}
