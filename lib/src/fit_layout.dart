import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';

class FitLayout extends StatelessWidget {
  const FitLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.laptop,
    this.desktop,
    this.desktopLarge,
  });

  final WidgetBuilder? mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? laptop;
  final WidgetBuilder? desktop;
  final WidgetBuilder? desktopLarge;

  @override
  Widget build(BuildContext context) {
    final size = useFitSize();
    Widget? child;

    switch (size) {
      case FitSize.mobile:
        child = mobile?.call(context);
        break;

      case FitSize.tablet:
        child = tablet?.call(context) ?? mobile?.call(context);
        break;

      case FitSize.laptop:
        child = laptop?.call(context) ??
            tablet?.call(context) ??
            mobile?.call(context);
        break;

      case FitSize.desktop:
        child = desktop?.call(context) ??
            laptop?.call(context) ??
            tablet?.call(context) ??
            mobile?.call(context);
        break;

      case FitSize.desktopLarge:
        child = desktopLarge?.call(context) ??
            desktop?.call(context) ??
            laptop?.call(context) ??
            tablet?.call(context) ??
            mobile?.call(context);
        break;
    }

    return child ?? Container();
  }
}
