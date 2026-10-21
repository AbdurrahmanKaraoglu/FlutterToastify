import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';

/// Maps a [NotificationPosition] to an [Alignment].
///
/// [NotificationPosition] değerini [Alignment] değerine çevirir.
extension NotificationPositionExtension on NotificationPosition {
  /// The matching [Alignment]. / Karşılık gelen [Alignment].
  Alignment get alignment {
    switch (this) {
      case NotificationPosition.center:
        return Alignment.center;
      case NotificationPosition.centerRight:
        return Alignment.centerRight;
      case NotificationPosition.centerLeft:
        return Alignment.centerLeft;
      case NotificationPosition.topCenter:
        return Alignment.topCenter;
      case NotificationPosition.topRight:
        return Alignment.topRight;
      case NotificationPosition.topLeft:
        return Alignment.topLeft;
      case NotificationPosition.bottomCenter:
        return Alignment.bottomCenter;
      case NotificationPosition.bottomRight:
        return Alignment.bottomRight;
      case NotificationPosition.bottomLeft:
        return Alignment.bottomLeft;
    }
  }
}

/// Maps a [NotificationType] to its color.
///
/// [NotificationType] değerini rengine çevirir.
extension NotificationTypeExtension on NotificationType {
  /// The style color from [AppConstants]. / [AppConstants] içindeki stil rengi.
  Color color() {
    switch (this) {
      case NotificationType.success:
        return AppConstants.successColor;
      case NotificationType.error:
        return AppConstants.errorColor;
      case NotificationType.info:
        return AppConstants.infoColor;
      case NotificationType.custom:
        return Colors.blue;
    }
  }
}
