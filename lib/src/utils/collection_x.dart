extension IterableX<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E value) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  num sumBy(num Function(E element) f) {
    num sum = 0;
    for (var element in this) {
      sum += f(element);
    }
    return sum;
  }

  int sumByInt(int Function(E element) f) {
    int sum = 0;
    for (var element in this) {
      sum += f(element);
    }
    return sum;
  }

  Map<K, List<E>> groupBy<K>(K Function(E value) keyFunction) {
    return fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) {
        return map..putIfAbsent(keyFunction(element), () => <E>[]).add(element);
      },
    );
  }

  List<List<E>> chunked(int size) {
    final list = toList();
    final chunks = <List<E>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(list.sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  List<E> uniqueBy<K>(K Function(E value) keyFunction) {
    final seen = <K>{};
    return where((element) {
      final key = keyFunction(element);
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();
  }
}

extension IterablesX<E> on Iterable<Iterable<E>> {
  List<E> expandList() {
    return expand((e) => e).toList();
  }
}

extension FutureIterableX<E> on Iterable<Future<E>> {
  Future<List<E>> awaitAll() {
    return Future.wait(this);
  }
}
