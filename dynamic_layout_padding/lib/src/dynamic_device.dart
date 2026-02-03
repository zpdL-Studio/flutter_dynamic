abstract interface class DynamicDevice {
  final double width;

  DynamicDevice({required this.width});
}

enum DefaultDynamicDevice implements DynamicDevice {
  mobile,
  table,
  desktop;

  @override
  double get width => switch (this) {
    DefaultDynamicDevice.mobile => 600,
    DefaultDynamicDevice.table => 840,
    DefaultDynamicDevice.desktop => 2048,
  };
}
