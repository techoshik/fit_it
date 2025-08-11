import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FitGrid extends HookConsumerWidget {
  final int Function(FitSize size) columns;
  final double spacing;
  final WrapCrossAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? layoutPadding;
  final List<Widget> children;

  const FitGrid({
    super.key,
    required this.columns,
    this.spacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.center,
    this.layoutPadding,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fitSize = useFitSize();
    final columnsCount = useState<int>(1);

    useEffect(() {
      columnsCount.value = columns(fitSize);
      return null;
    }, [fitSize]);

    return SingleChildScrollView(
      padding: layoutPadding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = (constraints.maxWidth / columnsCount.value) -
              ((spacing * (columnsCount.value - 1)) / columnsCount.value);

          return Wrap(
            runSpacing: spacing,
            spacing: spacing,
            crossAxisAlignment: crossAxisAlignment,
            children: List.generate(
              children.length,
              (index) => SizedBox(width: width, child: children[index]),
            ),
          );
        },
      ),
    );
  }
}
