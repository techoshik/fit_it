import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

FitSize useFitSize() {
  return use(_FitSizeHook());
}

class _FitSizeHook extends Hook<FitSize> {
  const _FitSizeHook();

  @override
  _FitSizeHookState createState() => _FitSizeHookState();
}

class _FitSizeHookState extends HookState<FitSize, _FitSizeHook> {
  @override
  FitSize build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FitSize.parse(width);
  }
}
