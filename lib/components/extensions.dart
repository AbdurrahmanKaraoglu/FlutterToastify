import 'package:flutter/material.dart';
import 'package:flutter_toastify/components/constants.dart';
import 'package:flutter_toastify/components/enums.dart';

// Bildirim konumları için Extension
extension NotificationPositionExtension on NotificationPosition {
  // Bu extension, her bir NotificationPosition değerini karşılık gelen Alignment değerine dönüştürür.
  // This extension converts each NotificationPosition value to the corresponding Alignment value.
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
      default:
        return Alignment.topCenter;
    }
  }
}

// Bildirim tipleri için Extension
extension NotificationTypeExtension on NotificationType {
  // Bu extension, her bir NotificationType değerini AppConstants sınıfında tanımlı renklerle eşleştirir ve ilgili rengi döndürür.
  // This extension maps each NotificationType value to the corresponding color defined in the AppConstants class and returns the associated color.
  Color color() {
    switch (this) {
      case NotificationType.success:
        return AppConstants.successColor;
      case NotificationType.error:
        return AppConstants.errorColor;
      case NotificationType.info:
        return AppConstants.inforColor;
      default:
        return Colors.blue;
    }
  }
}
