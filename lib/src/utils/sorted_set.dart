import 'dart:collection';

class SortedSet<T> {
  SortedSet(Comparator<T> comparator)
    : _items = LinkedHashSet(
        equals: (v1, v2) => (v1 == v2 ? 0 : comparator(v1, v2)) == 0,
      );

  final Set<T> _items;

  int get length => _items.length;

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  void add(T value) {
    _items.remove(value);
    _items.add(value);
  }

  void addAll(List<T> values) {
    _items.removeAll(values);
    _items.addAll(values);
  }

  void remove(T value) {
    _items.remove(value);
  }

  void clear() {
    _items.clear();
  }

  T get(int index) {
    return _items.elementAt(index);
  }

  T? getOrNull(int index) {
    try {
      return _items.elementAt(index);
    } catch (e) {
      return null;
    }
  }

  T? first({T? defaultValue}) {
    return _items.isEmpty ? defaultValue : _items.first;
  }

  T? last({T? defaultValue}) {
    return _items.isEmpty ? defaultValue : _items.last;
  }
}
