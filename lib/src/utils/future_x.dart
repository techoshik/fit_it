import 'dart:async';

class FitFutures {
  FitFutures._();

  static final instance = FitFutures._();
  static final _timers = <String, Timer>{};
  static final _completers = <String, List<Completer<dynamic>>>{};

  /// Debounces [action] so that only the last call within [duration] executes.
  /// All callers sharing the same [key] receive the result of that single execution.
  ///
  /// **Key contract:** every call with the same [key] must use the same type [T].
  /// Mixing types on the same key will cause a runtime cast error.
  ///
  /// **Widget disposal:** the returned future resolves even if the calling widget
  /// is disposed. Always check `mounted` before using the result to update state.
  Future<T> debounce<T>(
    Future<T> Function() action, {
    required String key,
    required Duration duration,
  }) {
    _timers[key]?.cancel();

    final completer = Completer<T>();
    _completers.putIfAbsent(key, () => []).add(completer);

    _timers[key] = Timer(duration, () async {
      final pending = _completers.remove(key) ?? [];
      _timers.remove(key);

      try {
        final result = await action();
        for (final c in pending) {
          if (!c.isCompleted) c.complete(result);
        }
      } catch (e, s) {
        for (final c in pending) {
          if (!c.isCompleted) c.completeError(e, s);
        }
      }
    });

    return completer.future;
  }

  /// Cancels a pending debounce for [key].
  /// The cancelled future is silently abandoned — the caller will never receive a result.
  void cancel(String key) {
    _timers[key]?.cancel();
    _timers.remove(key);
    _completers.remove(key);
  }

  /// Cancels all pending debounces.
  /// All cancelled futures are silently abandoned — callers will never receive a result.
  void cancelAll() {
    for (final t in _timers.values) {
      t.cancel();
    }
    _timers.clear();
    _completers.clear();
  }
}
