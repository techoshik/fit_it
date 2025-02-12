import 'package:fit_it/src/fit_breakpoints.dart';
import 'package:fit_it/fit_it.dart';

enum FitSize {
  mobile,
  tablet,
  laptop,
  desktop,
  desktopLarge;

  bool get isMobile => this == mobile;
  bool get isMobileOrAbove => isMobile;

  bool get isTablet => this == tablet;
  bool get isTabletOrAbove => isTablet || isLaptopOrAbove;
  bool get isTabletOrBelow => isTablet || isMobile;

  bool get isLaptop => this == laptop;
  bool get isLaptopOrAbove => isLaptop || isDesktop;
  bool get isLaptopOrBelow => isLaptop || isTabletOrBelow;

  bool get isDesktop => this == desktop;
  bool get isDesktopOrAbove => isDesktop || isDesktopLarge;
  bool get isDesktopOrBelow => isDesktop || isLaptopOrBelow;

  bool get isDesktopLarge => this == desktopLarge;

  static FitSize parse(double width, FitBreakpoints points) {
    if (width <= points.mobile) return FitSize.mobile;
    if (width <= points.tablet) return FitSize.tablet;
    if (width <= points.laptop) return FitSize.laptop;
    if (width <= points.desktop) return FitSize.desktop;
    return FitSize.desktopLarge;
  }
}
