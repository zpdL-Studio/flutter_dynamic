extension StringExtension on String {
  String dynamicSubString(int start, [int? end]) {
    int s = start > length ? length : start;
    int? e;
    if (end != null) {
      if (s > end) {
        return substring(s, s);
      }
      e = end > length ? length : end;
    }
    return substring(s, e);
  }
}

extension StringNullableExtension on String? {
  bool get isEmptyOrNull => this?.isEmpty ?? true;

  bool get isNotEmptyAndNotNull => this?.isNotEmpty ?? false;
}

class DynamicString {
  static String combine(List<String?> list, [String divider = '']) {
    StringBuffer sb = StringBuffer();
    for (final s in list) {
      if (s == null || s.isEmpty) {
        continue;
      }

      if (sb.isNotEmpty) {
        sb.write(divider);
      }
      sb.write(s);
    }

    return sb.toString();
  }
}
