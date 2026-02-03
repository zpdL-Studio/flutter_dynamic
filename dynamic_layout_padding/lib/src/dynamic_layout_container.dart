import 'package:dynamic_layout_padding/src/dynamic_layout_padding.dart';
import 'package:flutter/widgets.dart';

class DynamicLayoutContainer extends StatelessWidget {
  const DynamicLayoutContainer({
    super.key,
    this.alignment,
    this.backgroundColor,
    this.withDevicePadding,
    this.decoration,
    this.foregroundDecoration,
    required this.child,
  });

  final AlignmentGeometry? alignment;

  final Color? backgroundColor;
  final bool? withDevicePadding;

  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layoutPadding = DynamicLayoutPadding.layoutPaddingOf(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: layoutPadding),
      color: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      child: child,
    );
  }
}
