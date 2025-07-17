import 'package:dynamic_layout_padding/src/dynamic_layout_padding.dart';
import 'package:flutter/widgets.dart';

class DynamicLayoutContainer extends StatelessWidget {
  const DynamicLayoutContainer({
    super.key,
    this.backgroundColor,
    this.withDevicePadding,
    this.decoration,
    this.foregroundDecoration,
    required this.child,
  });

  final Color? backgroundColor;
  final bool? withDevicePadding;

  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layoutPadding = DynamicLayoutPadding.layoutPaddingOf(context);
    final devicePadding =
        withDevicePadding == true
            ? DynamicLayoutPadding.deviceOf(context).padding
            : 0;

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: layoutPadding + devicePadding),
      alignment: AlignmentDirectional.center,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      child: child,
    );
  }
}
