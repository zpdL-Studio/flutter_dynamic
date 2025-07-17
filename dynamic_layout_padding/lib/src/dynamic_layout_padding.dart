import 'package:dynamic_layout_padding/src/dynamic_device.dart';
import 'package:flutter/widgets.dart';

class DynamicLayoutPadding<T extends DynamicDevice> extends StatelessWidget {
  static T deviceOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.device,
    )!.device;
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

  static bool shownKeyboardOf<T extends DynamicDevice>(BuildContext context) {
    return InheritedModel.inheritFrom<_DynamicLayoutPadding<T>>(
      context,
      aspect: _DynamicLayoutPaddingDependencies.shownKeyboard,
    )!.shownKeyboard;
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
    final shownKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;
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
          layoutWidth: compute.layoutWidth,
          layoutPadding: compute.layoutPadding,
          shownKeyboard: shownKeyboard,
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
  layoutWidth,
  layoutPadding,
  shownKeyboard,
}

class _DynamicLayoutPadding<T extends DynamicDevice>
    extends InheritedModel<_DynamicLayoutPaddingDependencies> {
  final T device;
  final double height;
  final double deviceWidth;
  final double layoutWidth;
  final double layoutPadding;
  final bool shownKeyboard;

  const _DynamicLayoutPadding({
    required this.device,
    required this.height,
    required this.deviceWidth,
    required this.layoutWidth,
    required this.layoutPadding,
    required this.shownKeyboard,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _DynamicLayoutPadding oldWidget) {
    return device != oldWidget.device ||
        height != oldWidget.height ||
        deviceWidth != oldWidget.deviceWidth ||
        layoutWidth != oldWidget.layoutWidth ||
        layoutPadding != oldWidget.layoutPadding ||
        shownKeyboard != oldWidget.shownKeyboard;
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
        case _DynamicLayoutPaddingDependencies.shownKeyboard:
          if (shownKeyboard != oldWidget.shownKeyboard) {
            return true;
          }
          break;
      }
    }

    return false;
  }
}
