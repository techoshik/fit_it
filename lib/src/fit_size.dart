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

  static FitSize parse(double width, FitBreakpoints points) {
    if (width <= points.mobile) return FitSize.mobile;
    if (width <= points.tablet) return FitSize.tablet;
    if (width <= points.laptop) return FitSize.laptop;
    if (width <= points.desktop) return FitSize.desktop;
    return FitSize.desktopLarge;
  }
}
