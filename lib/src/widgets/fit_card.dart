import 'package:fit_it/fit_it.dart';
import 'package:flutter/material.dart';

/// Spacing tokens for [FitCard.padding], [FitCard.margin], and [FitCard.radius].
///
/// `small`/`medium`/`large` use axis-based spacing (independent horizontal
/// and vertical values); the `*Uniform` variants use the same value on all
/// sides. For [FitCard.radius] both forms of a given size resolve the same.
enum FitCardSpacing {
  zero,
  small,
  smallUniform,
  medium,
  mediumUniform,
  large,
  largeUniform,
}

/// Surface style of the card body.
enum FitCardStyle {
  /// No surface, elevation, or border — just the header and child.
  none,

  /// Renders [FitCard.child] inside a [Card] with elevation.
  card,

  /// Renders [FitCard.child] inside a bordered container, no elevation.
  outlined,

  /// Renders [FitCard.child] inside a bordered container with a filled
  /// surface — combines [card] and [outlined].
  cardWithOutline,
}

/// Text style size used for [FitCard.title].
enum FitCardTitleSize { medium, large }

/// A section with an optional header (title/subtitle/actions) and a body,
/// with configurable padding, margin, corner radius, and surface style.
class FitCard extends StatelessWidget {
  /// Spacing between the card surface and [child]. Defaults to
  /// [FitCardSpacing.largeUniform].
  final FitCardSpacing padding;

  /// Spacing around the outside of the card (and header, when rendered
  /// above it). Defaults to [FitCardSpacing.large].
  final FitCardSpacing margin;

  /// Corner radius, ignored when [style] is [FitCardStyle.none]. Defaults
  /// to [FitCardSpacing.medium].
  final FitCardSpacing radius;

  /// Surface style of the card. Defaults to [FitCardStyle.none].
  final FitCardStyle style;

  final Widget child;

  /// Overrides the card's background color.
  final Color? backgroundColor;

  /// Overrides the border color when [style] is [FitCardStyle.outlined] or
  /// [FitCardStyle.cardWithOutline].
  final Color? outlineColor;

  /// Whether the card expands to fill the available vertical space.
  /// Defaults to false.
  final bool expanded;

  /// Widgets shown at the end of the header row, alongside the title.
  final List<Widget>? actions;

  /// Header title. When null, no header is rendered.
  final String? title;

  /// Header subtitle, shown below [title].
  final String? subtitle;

  /// Overrides the header's padding. Ignored unless [useHeaderOutsideCard]
  /// is true, in which case the header has no padding of its own.
  final EdgeInsets? titlePadding;

  /// Text style size for [title]. Defaults to [FitCardTitleSize.medium].
  final FitCardTitleSize titleSize;

  /// When true, the header renders above the card instead of inside its
  /// surface, above [child]. Defaults to false.
  final bool useHeaderOutsideCard;

  const FitCard({
    super.key,
    required this.child,
    this.padding = FitCardSpacing.largeUniform,
    this.margin = FitCardSpacing.large,
    this.radius = FitCardSpacing.large,
    this.style = FitCardStyle.cardWithOutline,
    this.backgroundColor,
    this.outlineColor,
    this.expanded = false,
    this.actions,
    this.title,
    this.subtitle,
    this.titlePadding,
    this.titleSize = FitCardTitleSize.medium,
    this.useHeaderOutsideCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final insetSmallUniform = EdgeInsets.all(FitIt.defaultFitSpacing.small);
    final insetMediumUniform = EdgeInsets.all(FitIt.defaultFitSpacing.medium);
    final insetLargeUniform = EdgeInsets.all(FitIt.defaultFitSpacing.large);

    final insetSmall = EdgeInsets.symmetric(
      vertical: FitIt.defaultFitSpacing.small / 2,
      horizontal: FitIt.defaultFitSpacing.small,
    );
    final insetMedium = EdgeInsets.symmetric(
      vertical: FitIt.defaultFitSpacing.small,
      horizontal: FitIt.defaultFitSpacing.medium,
    );
    final insetLarge = EdgeInsets.symmetric(
      vertical: FitIt.defaultFitSpacing.medium,
      horizontal: FitIt.defaultFitSpacing.large,
    );

    final padding = switch (this.padding) {
      FitCardSpacing.zero => EdgeInsets.zero,
      FitCardSpacing.small => insetSmall,
      FitCardSpacing.smallUniform => insetSmallUniform,
      FitCardSpacing.medium => insetMedium,
      FitCardSpacing.mediumUniform => insetMediumUniform,
      FitCardSpacing.large => insetLarge,
      FitCardSpacing.largeUniform => insetLargeUniform,
    };
    final margin = switch (this.margin) {
      FitCardSpacing.zero => EdgeInsets.zero,
      FitCardSpacing.small => insetSmall,
      FitCardSpacing.smallUniform => insetSmallUniform,
      FitCardSpacing.medium => insetMedium,
      FitCardSpacing.mediumUniform => insetMediumUniform,
      FitCardSpacing.large => insetLarge,
      FitCardSpacing.largeUniform => insetLargeUniform,
    };
    final radius = switch (this.radius) {
      FitCardSpacing.zero => 0.0,
      FitCardSpacing.small ||
      FitCardSpacing.smallUniform =>
        FitIt.defaultFitRadius.small,
      FitCardSpacing.medium ||
      FitCardSpacing.mediumUniform =>
        FitIt.defaultFitRadius.medium,
      FitCardSpacing.large ||
      FitCardSpacing.largeUniform =>
        FitIt.defaultFitRadius.large,
    };

    final titleSize = switch (this.titleSize) {
      FitCardTitleSize.medium => context.textTheme.titleMedium,
      FitCardTitleSize.large => context.textTheme.titleLarge,
    };

    final shape = style == FitCardStyle.none
        ? RoundedRectangleBorder()
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: (style == FitCardStyle.outlined ||
                    style == FitCardStyle.cardWithOutline)
                ? BorderSide(
                    color: outlineColor ?? context.colorScheme.outlineVariant,
                  )
                : BorderSide.none,
          );

    final color = backgroundColor ??
        switch (style) {
          FitCardStyle.card => null,
          FitCardStyle.outlined => context.colorScheme.surface,
          FitCardStyle.cardWithOutline => context.colorScheme.surfaceContainer,
          FitCardStyle.none => Colors.transparent,
        };

    final subtitleStyle =
        useHeaderOutsideCard ? null : context.textTheme.labelLarge;

    final headerPadding = useHeaderOutsideCard
        ? titlePadding ??
            EdgeInsets.only(
              top: FitIt.defaultFitSpacing.large,
              left: FitIt.defaultFitSpacing.medium,
              right: FitIt.defaultFitSpacing.small,
              bottom: FitIt.defaultFitSpacing.small,
            )
        : EdgeInsets.only(bottom: padding.top);

    final header = title == null
        ? null
        : Padding(
            padding: headerPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: FitIt.defaultFitSpacing.small,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title!, style: titleSize),
                      if (subtitle != null)
                        Text(subtitle!, style: subtitleStyle),
                    ],
                  ),
                ),
                ...?actions,
              ],
            ),
          );

    return Padding(
      padding: margin,
      child: Column(
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (useHeaderOutsideCard && header != null) header,
          Expanded(
            flex: expanded ? 1 : 0,
            child: Card(
              margin: EdgeInsets.all(0),
              shape: shape,
              color: color,
              elevation: 0,
              child: Padding(
                padding: padding,
                child: Column(
                  children: [
                    if (!useHeaderOutsideCard && header != null) header,
                    child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
