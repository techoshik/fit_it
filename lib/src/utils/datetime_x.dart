import 'package:flutter/material.dart';

extension DateTimeX on DateTime {
  //
  Duration subtract(DateTime value) {
    var startDuration = Duration(milliseconds: value.millisecondsSinceEpoch);
    var endDuration = Duration(milliseconds: millisecondsSinceEpoch);
    return endDuration - startDuration;
  }

  int get secondsSinceEpoch {
    return Duration(milliseconds: millisecondsSinceEpoch).inSeconds;
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }

  DateTimeRange get dayRange {
    return DateTimeRange(start: startOfDay, end: endOfDay);
  }
}
