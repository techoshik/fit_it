import 'package:flutter/material.dart';

abstract class KeyboardUtils {
  //

  static void focus(FocusNode? node) {
    final context = node?.context;
    if (context == null) return;
    FocusScope.of(context).requestFocus(node);
  }
}
