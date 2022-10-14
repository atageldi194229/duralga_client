import 'dart:async';

class InfinityFetcher {
  Duration duration = const Duration(seconds: 5);
  Function? callback;
  Timer? timer;

  start({
    Duration? duration,
    Function? callback,
  }) {
    if (duration != null) this.duration = duration;
    if (callback != null) this.callback = callback;

    stop();

    this.callback?.call();
    timer = Timer.periodic(this.duration, (_) {
      this.callback?.call();
    });
  }

  stop() {
    timer?.cancel();
  }
}
