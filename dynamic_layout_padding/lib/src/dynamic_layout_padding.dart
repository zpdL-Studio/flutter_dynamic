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
      aspect: _DynamicLayoutPaddingDependencies.layoutWidth,
    )!.layoutWidth;
  }

  static double heightOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.height,
    )!.height;
  }

  static double deviceWidthOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.deviceWidth,
    )!.deviceWidth;
  }

  static double devicePaddingOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.devicePadding,
    )!.devicePadding;
  }

  static double layoutPaddingOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.layoutPadding,
    )!.layoutPadding;
  }

  static double paddingOf<T extends DynamicDevice>(BuildContext context) {
    return layoutPaddingOf<T>(context) + devicePaddingOf<T>(context);
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
          height: constraints.maxHeight,
          deviceWidth: compute.deviceWidth,
          devicePadding: compute.device.padding,
          layoutWidth: compute.layoutWidth,
          layoutPadding: compute.layoutPadding,
          child: child,
        );
      },
    );
  }
}

class _DynamicLayoutCompute {
  final DynamicDevice device;
  final double deviceWidth;
  final double layoutWidth;
  final double layoutPadding;

  _DynamicLayoutCompute._({
    required this.device,
    required this.deviceWidth,
    required this.layoutWidth,
    required this.layoutPadding,
  });

  factory _DynamicLayoutCompute.fromDevice(
    List<DynamicDevice> devices,
    double layoutWidth,
  ) {
    final device = _computeDevice(devices, layoutWidth);
    final remainLayoutWidth = layoutWidth - device.width;
    if (remainLayoutWidth < 0) {
      return _DynamicLayoutCompute._(
        device: device,
        deviceWidth: layoutWidth,
        layoutWidth: layoutWidth,
        layoutPadding: 0,
      );
    }

    return _DynamicLayoutCompute._(
      device: device,
      deviceWidth: layoutWidth - remainLayoutWidth,
      layoutWidth: layoutWidth,
      layoutPadding: remainLayoutWidth / 2,
    );
  }

  static DynamicDevice _computeDevice(
    List<DynamicDevice> devices,
    double width,
  ) {
    for (final device in devices) {
      if (width < device.width) {
        return device;
      }
    }
    return devices.last;
  }
}

enum _DynamicLayoutPaddingDependencies {
  device,
  height,
  deviceWidth,
  devicePadding,
  layoutWidth,
  layoutPadding,
}

class _DynamicLayoutPadding<T extends DynamicDevice>
    extends InheritedModel<_DynamicLayoutPaddingDependencies> {
  final T device;
  final double height;
  final double deviceWidth;
  final double devicePadding;
  final double layoutWidth;
  final double layoutPadding;

  const _DynamicLayoutPadding({
    required this.device,
    required this.height,
    required this.deviceWidth,
    required this.devicePadding,
    required this.layoutWidth,
    required this.layoutPadding,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _DynamicLayoutPadding oldWidget) {
    return device != oldWidget.device ||
        height != oldWidget.height ||
        deviceWidth != oldWidget.deviceWidth ||
        devicePadding != oldWidget.devicePadding ||
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
        case _DynamicLayoutPaddingDependencies.height:
          if (height != oldWidget.height) {
            return true;
          }
          break;
        case _DynamicLayoutPaddingDependencies.deviceWidth:
          if (deviceWidth != oldWidget.deviceWidth) {
            return true;
          }
          break;
        case _DynamicLayoutPaddingDependencies.devicePadding:
          if (devicePadding != oldWidget.devicePadding) {
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
