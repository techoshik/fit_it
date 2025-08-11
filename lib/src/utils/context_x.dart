import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  /// Returns the [ThemeData] of the current context.
  ThemeData get theme => Theme.of(this);

  /// Returns the [TextTheme] of the current context.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the [ColorScheme] of the current context.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the [Brightness] of the current context.
  Brightness get brightness => theme.brightness;

  /// Returns the [MediaQueryData] of the current context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the [Size] of the current context.
  Size get screenSize => mediaQuery.size;
}
