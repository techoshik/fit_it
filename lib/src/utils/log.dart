import 'dart:convert';

import 'package:fit_it/src/utils/collection_x.dart';
import 'package:flutter/foundation.dart';

abstract class Log {
  static final int _funIndex = 3;

  ///
  /// Log levels
  ///
  static void _log(List list) {
    final message = list.where((v) => v != null).map(_toJsonString).join(' : ');
    // ignore: avoid_print
    print(message);
  }

  /// Debug
  static void d(dynamic message, [dynamic data, dynamic stack]) {
    if (kDebugMode) {
      _log(['DEBUG', stackFunctionNames[_funIndex], message, data, stack]);
    }
  }

  /// Info
  static void i(dynamic message, [dynamic data, dynamic stack]) {
    _log(['INFO', stackFunctionNames[_funIndex], message, data, stack]);
  }

  /// Warning
  static void w(dynamic message, [dynamic data, dynamic stack]) {
    _log(['WARN', stackFunctionNames[_funIndex], message, data, stack]);
  }

  /// Error
  static void e(dynamic message, [dynamic data, dynamic stack]) {
    _log(['ERROR', stackFunctionNames[_funIndex], message, data, stack]);
  }

  static String _toJsonString(dynamic obj) {
    try {
      return jsonEncode(obj);
    } catch (e) {
      return '$obj';
    }
  }

  static List<String> get stackFunctionNames {
    return StackTrace.current
        .toString()
        .split('\n')
        .map(
          (frame) => frame
              .split(' ')
              .firstWhereOrNull((part) => part.trim().isNotEmpty),
        )
        .whereType<String>()
        .toList();
  }
}
