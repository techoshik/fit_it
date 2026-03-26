import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hooks_riverpod/legacy.dart';

final _fitLoaderProvider = StateProvider<bool>((ref) {
  return false;
});

extension RiverpodX on WidgetRef {
  void showFitLoader(bool value) {
    read(_fitLoaderProvider.notifier).state = value;
  }
}

/// Just wrap your app widget with FitLoader
/// And use [ref.showFitLoader(true/false)]
///
/// If you use [MaterialApp.router] for pages,
/// Use the `builder` callback to build loader
/// ```
/// builder: (context, child) {
///   return FitLoader(
///     child: child,
///   );
/// },
/// ```
class FitLoader extends HookConsumerWidget {
  final Widget? child;
  final Widget? customLoader;

  const FitLoader({
    super.key,
    required this.child,
    this.customLoader,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(_fitLoaderProvider);

    return ModalProgressHUD(
      inAsyncCall: visible,
      progressIndicator: customLoader ?? _DefaultLoader(),
      child: child ?? SizedBox.shrink(),
    );
  }
}

class _DefaultLoader extends StatelessWidget {
  const _DefaultLoader();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: CircularProgressIndicator(
          strokeWidth: 5,
          backgroundColor: Colors.grey.shade300,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
