import 'package:dynamic_layout_padding/src/dynamic_device.dart';
import 'package:flutter/widgets.dart';

class DynamicLayoutPadding<T extends DynamicDevice> extends StatelessWidget {
  static T deviceOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.device,
    )!.device;
  }

  static double widthOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.width,
    )!.width;
  }

  static double heightOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.height,
    )!.height;
  }

  static double layoutWidthOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.layoutWidth,
    )!.layoutWidth;
  }

  static double layoutPaddingOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.layoutPadding,
    )!.layoutPadding;
  }

  const DynamicLayoutPadding({
    super.key,
    required this.devices,
    required this.child,
  });

  final List<T> devices;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compute = _DynamicLayoutCompute.fromDevice(
          devices,
          constraints.maxWidth,
        );

        return _DynamicLayoutPadding(
          device: compute.device,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          layoutWidth: compute.width,
          layoutPadding: compute.padding,
          child: child,
        );
      },
    );
  }
}

class _DynamicLayoutCompute {
  final DynamicDevice device;
  final double width;
  final double padding;

  _DynamicLayoutCompute._({
    required this.device,
    required this.width,
    required this.padding,
  });

  factory _DynamicLayoutCompute.fromDevice(
    List<DynamicDevice> devices,
    double maxWidth,
  ) {
    final device = _computeDevice(devices, maxWidth);
    final remainWidth = maxWidth - device.width;
    if (remainWidth < 0) {
      return _DynamicLayoutCompute._(
        device: device,
        width: maxWidth,
        padding: 0,
      );
    }

    return _DynamicLayoutCompute._(
      device: device,
      width: maxWidth - remainWidth,
      padding: remainWidth / 2,
    );
  }

  static DynamicDevice _computeDevice(
    List<DynamicDevice> devices,
    double width,
  ) {
    for (final device in devices) {
      if (width <= device.width) {
        return device;
      }
    }
    return devices.last;
  }
}

enum _DynamicLayoutPaddingDependencies {
  device,
  width,
  height,
  layoutWidth,
  layoutPadding,
}

class _DynamicLayoutPadding<T extends DynamicDevice>
    extends InheritedModel<_DynamicLayoutPaddingDependencies> {
  final T device;
  final double width;
  final double height;
  final double layoutWidth;
  final double layoutPadding;

  const _DynamicLayoutPadding({
    required this.device,
    required this.width,
    required this.height,
    required this.layoutWidth,
    required this.layoutPadding,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _DynamicLayoutPadding oldWidget) {
    return device != oldWidget.device ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        layoutWidth != oldWidget.layoutWidth ||
        layoutPadding != oldWidget.layoutPadding;
  }

  @override
  bool updateShouldNotifyDependent(
    _DynamicLayoutPadding<T> oldWidget,
    Set<_DynamicLayoutPaddingDependencies> dependencies,
  ) {
    for (final dependency in _DynamicLayoutPaddingDependencies.values) {
      if (!dependencies.contains(dependency)) {
        continue;
      }

      switch (dependency) {
        case _DynamicLayoutPaddingDependencies.device:
          if (device != oldWidget.device) {
            return true;
          }
          break;
        case _DynamicLayoutPaddingDependencies.width:
          if (width != oldWidget.width) {
            return true;
          }
          break;
        case _DynamicLayoutPaddingDependencies.height:
          if (height != oldWidget.height) {
            return true;
          }
          break;
        case _DynamicLayoutPaddingDependencies.layoutWidth:
          if (layoutWidth != oldWidget.layoutWidth) {
            return true;
          }
          break;
        case _DynamicLayoutPaddingDependencies.layoutPadding:
          if (layoutPadding != oldWidget.layoutPadding) {
            return true;
          }
          break;
      }
    }

    return false;
  }
}
