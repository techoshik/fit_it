import 'package:fit_it/src/fit_breakpoints.dart';
import 'package:fit_it/fit_it.dart';

enum FitSize {
  mobile,
  tablet,
  laptop,
  desktop,
  desktopLarge;

  bool get isMobile => this == mobile;
  bool get isTablet => this == tablet;
  bool get isLaptop => this == laptop;
  bool get isDesktop => this == desktop;
  bool get isDesktopLarge => this == desktopLarge;

  bool get isMobileOrAbove => isMobile;
  bool get isTabletOrAbove => isTablet || isLaptopOrAbove;
  bool get isLaptopOrAbove => isLaptop || isDesktopOrAbove;
  bool get isDesktopOrAbove => isDesktop || isDesktopLarge;

  bool get isTabletOrBelow => isTablet || isMobile;
  bool get isLaptopOrBelow => isLaptop || isTabletOrBelow;
  bool get isDesktopOrBelow => isDesktop || isLaptopOrBelow;

  T map<T>({
    required T Function() mobile,
    required T Function() tablet,
    required T Function() laptop,
    required T Function() desktop,
    required T Function() desktopLarge,
  }) {
    switch (this) {
      case FitSize.mobile:
        return mobile();
      case FitSize.tablet:
        return tablet();
      case FitSize.laptop:
        return laptop();
      case FitSize.desktop:
        return desktop();
      case FitSize.desktopLarge:
        return desktopLarge();
    }
  }

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? mobile,
    T Function()? tablet,
    T Function()? laptop,
    T Function()? desktop,
    T Function()? desktopLarge,
  }) {
    switch (this) {
      case FitSize.mobile:
        return mobile?.call() ?? orElse();
      case FitSize.tablet:
        return tablet?.call() ?? orElse();
      case FitSize.laptop:
        return laptop?.call() ?? orElse();
      case FitSize.desktop:
        return desktop?.call() ?? orElse();
      case FitSize.desktopLarge:
        return desktopLarge?.call() ?? orElse();
    }
  }

  static FitSize parse(double width, FitBreakpoints points) {
    if (width <= points.mobile) return FitSize.mobile;
    if (width <= points.tablet) return FitSize.tablet;
    if (width <= points.laptop) return FitSize.laptop;
    if (width <= points.desktop) return FitSize.desktop;
    return FitSize.desktopLarge;
  }
}
