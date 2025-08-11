import 'package:fit_it/src/widgets/fit_breakpoints.dart';
import 'package:fit_it/src/widgets/fit_size.dart';

export 'package:fit_it/src/utils/utils.dart';
export 'package:fit_it/src/widgets/widgets.dart';

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
}
