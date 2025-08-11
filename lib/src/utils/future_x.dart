import 'dart:async';

final timers = <String, Timer?>{};
final completers = <String, Completer?>{};

Future<void> debounce(String uniqueId, Duration duration) async {
  completers[uniqueId] = Completer();

  timers[uniqueId]?.cancel();
  timers[uniqueId] = Timer.periodic(duration, (timer) {
    if (completers[uniqueId]?.isCompleted == true) {
      completers[uniqueId] = Completer();
    }
    completers[uniqueId]?.complete();
  });

  return await completers[uniqueId]?.future;
}
