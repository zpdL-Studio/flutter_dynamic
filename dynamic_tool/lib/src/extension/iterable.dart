extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T e) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

