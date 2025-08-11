class SortedList<T> {
  SortedList(this._comparator);

  final List<T> _items = [];
  final Comparator<T> _comparator;

  int get length => _items.length;

  void add(T value) {
    _items.add(value);
    _items.sort(_comparator);
  }

  void addAll(List<T> values) {
    _items.addAll(values);
    _items.sort(_comparator);
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

  T? first({T? defaultValue}) {
    return _items.isEmpty ? defaultValue : _items.first;
  }

  T? last({T? defaultValue}) {
    return _items.isEmpty ? defaultValue : _items.last;
  }
}
