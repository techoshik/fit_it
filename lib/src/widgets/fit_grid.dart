import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FitGrid extends HookConsumerWidget {
  final int Function(FitSize size) columns;
  final double Function(FitSize size)? spacing;
  final EdgeInsetsGeometry Function(FitSize size)? layoutPadding;
  final WrapCrossAlignment Function(FitSize size)? crossAxisAlignment;
  final List<Widget> Function(FitSize size) children;

  const FitGrid({
    super.key,
    required this.columns,
    this.spacing,
    this.crossAxisAlignment,
    this.layoutPadding,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fitSize = useFitSize();
    final columnsCount = useState<int>(1);
    final spacingValue = useState(0.0);
    final padding = useState<EdgeInsetsGeometry?>(null);
    final crossAlignment = useState(WrapCrossAlignment.center);
    final childrenList = useState<List<Widget>>(children(fitSize));

    useEffect(() {
      columnsCount.value = columns(fitSize);
      spacingValue.value = spacing?.call(fitSize) ?? 0.0;
      padding.value = layoutPadding?.call(fitSize);
      crossAlignment.value =
          crossAxisAlignment?.call(fitSize) ?? WrapCrossAlignment.center;
      childrenList.value = children(fitSize);
      return null;
    }, [fitSize]);

    return SingleChildScrollView(
      padding: padding.value,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final space = spacingValue.value;
          final width = (constraints.maxWidth / columnsCount.value) -
              ((space * (columnsCount.value - 1)) / columnsCount.value);

          return Wrap(
            runSpacing: space,
            spacing: space,
            crossAxisAlignment: crossAlignment.value,
            children: childrenList.value.map((e) {
              return SizedBox(width: width, child: e);
            }).toList(),
          );
        },
      ),
    );
  }
}
