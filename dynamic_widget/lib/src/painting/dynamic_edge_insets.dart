import 'package:flutter/widgets.dart' show EdgeInsetsDirectional;

class DynamicEdgeInsets extends EdgeInsetsDirectional {
  const DynamicEdgeInsets(
      {double? all,
      double? vertical,
      double? horizontal,
      double? start,
      double? top,
      double? end,
      double? bottom})
      : super.only(
          start: (start ?? (horizontal ?? (all ?? 0))) >= 0
              ? (start ?? (horizontal ?? (all ?? 0)))
              : 0,
          end: (end ?? (horizontal ?? (all ?? 0))) >= 0
              ? (end ?? (horizontal ?? (all ?? 0)))
              : 0,
          top: (top ?? (vertical ?? (all ?? 0))) >= 0
              ? (top ?? (vertical ?? (all ?? 0)))
              : 0,
          bottom: (bottom ?? (vertical ?? (all ?? 0))) >= 0
              ? bottom ?? (vertical ?? (all ?? 0))
              : 0,
        );
}
