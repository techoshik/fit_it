import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fitScaffoldDrawerProvider = StateProvider<DateTime?>((ref) => null);

class FitScaffold extends HookConsumerWidget {
  final _key = GlobalKey<ScaffoldState>();

  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? leftNavigation;
  final Widget? rightNavigation;
  final Widget? bottomNavigationBar;
  final Widget body;

  /// Default value is [FitIt.appBarVisibleOn]
  final List<FitSize>? appBarVisibleOn;

  /// Default value is [FitIt.drawerVisibleOn]
  final List<FitSize>? drawerVisibleOn;

  /// Default value is [FitIt.leftNavigationVisibleOn]
  final List<FitSize>? leftNavigationVisibleOn;

  /// Default value is [FitIt.rightNavigationVisibleOn]
  final List<FitSize>? rightNavigationVisibleOn;

  /// Default value is [FitIt.bottomNavigationBarVisibleOn]
  final List<FitSize>? bottomNavigationVisibleOn;

  final double leftNavigationWidth;
  final double rightNavigationWidth;

  FitScaffold({
    this.appBar,
    this.drawer,
    this.leftNavigation,
    this.rightNavigation,
    this.bottomNavigationBar,
    this.appBarVisibleOn,
    this.drawerVisibleOn,
    this.leftNavigationVisibleOn,
    this.rightNavigationVisibleOn,
    this.bottomNavigationVisibleOn,
    this.leftNavigationWidth = 250,
    this.rightNavigationWidth = 200,
    required this.body,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = useFitSize();

    ref.listen(fitScaffoldDrawerProvider, (previous, next) {
      if (next != null) {
        _key.currentState?.openDrawer();
      }
    });

    final showAppBar =
        (appBarVisibleOn ?? FitIt.appBarVisibleOn).contains(size);
    final showDrawer =
        (drawerVisibleOn ?? FitIt.drawerVisibleOn).contains(size);
    final showBottomBar =
        (bottomNavigationVisibleOn ?? FitIt.bottomNavigationBarVisibleOn)
            .contains(size);
    final showLeftNav =
        (leftNavigationVisibleOn ?? FitIt.leftNavigationVisibleOn)
            .contains(size);
    final showRightNav =
        (rightNavigationVisibleOn ?? FitIt.rightNavigationVisibleOn)
            .contains(size);

    return Scaffold(
      key: _key,
      appBar: showAppBar ? appBar : null,
      drawer: showDrawer ? drawer : null,
      bottomNavigationBar: showBottomBar ? bottomNavigationBar : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showLeftNav && leftNavigation != null)
            SizedBox(
              width: leftNavigationWidth,
              child: leftNavigation!,
            ),
          Expanded(
            child: body,
          ),
          if (showRightNav && rightNavigation != null)
            SizedBox(
              width: rightNavigationWidth,
              child: rightNavigation!,
            ),
        ],
      ),
    );
  }
}
