enum DynamicDevice {
  mobile,
  tablet,
  desktop;

  static DynamicDevice getDevice(double width, {})
}

const double dynamicDeviceMobileMaxWidth = 600;
const double dynamicDeviceTabletMaxWidth = 840;