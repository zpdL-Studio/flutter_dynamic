abstract interface class DynamicDevice {
  final double width;
  final double padding;

  DynamicDevice({required this.width, required this.padding});
}

enum DefaultDynamicDevice implements DynamicDevice {
  mobile,
  table,
  desktop;

  @override
  double get padding => switch (this) {
    DefaultDynamicDevice.mobile => 16,
    DefaultDynamicDevice.table => 32,
    DefaultDynamicDevice.desktop => 48,
  };

  @override
  double get width => switch (this) {
    DefaultDynamicDevice.mobile => 600,
    DefaultDynamicDevice.table => 840,
    DefaultDynamicDevice.desktop => 2048,
  };
}
