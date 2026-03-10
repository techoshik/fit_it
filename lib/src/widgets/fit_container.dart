import 'package:fit_it/fit_it.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FitContainer extends HookConsumerWidget {
  final FitSize? maxFitSize;
  final double? maxWidth;
  final Widget? child;

  const FitContainer({super.key, this.maxFitSize, this.maxWidth, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxFitSize?.maxWidth ?? maxWidth ?? double.infinity,
        ),
        child: child,
      ),
    );
  }
}
