import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(
      this.year,
      this.month,
      this.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }
}
