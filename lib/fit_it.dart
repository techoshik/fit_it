import 'package:fit_it/src/fit_breakpoints.dart';
import 'package:fit_it/src/fit_size.dart';
import 'package:flutter/material.dart';

export 'package:fit_it/src/fit_breakpoints.dart';
export 'package:fit_it/src/fit_layout.dart';
export 'package:fit_it/src/fit_scaffold.dart';
export 'package:fit_it/src/fit_size.dart';

abstract class FitIt {
  static FitBreakpoints breakpoints = (
    mobile: 450,
    tablet: 800,
    laptop: 1100,
    desktop: 1450,
  );
  static List<FitSize> appBarVisibleOn = [
    FitSize.mobile,
  ];
  static List<FitSize> drawerVisibleOn = [
    FitSize.mobile,
  ];
  static List<FitSize> leftNavigationVisibleOn = [
    FitSize.tablet,
    FitSize.laptop,
    FitSize.desktop,
    FitSize.desktopLarge,
  ];
  static List<FitSize> rightNavigationVisibleOn = [
    FitSize.desktop,
    FitSize.desktopLarge,
  ];
  static List<FitSize> bottomNavigationBarVisibleOn = [
    FitSize.mobile,
  ];

  static FitSize getSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FitSize.parse(width, FitIt.breakpoints);
  }

  static Size getWindowSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
