import 'dart:async';
import 'package:flutter/material.dart';

class MyLocationWaitingAnimatedIcon extends StatefulWidget {
  const MyLocationWaitingAnimatedIcon({
    Key? key,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  final Duration duration;

  @override
  State<MyLocationWaitingAnimatedIcon> createState() =>
      _MyLocationWaitingAnimatedIconState();
}

class _MyLocationWaitingAnimatedIconState
    extends State<MyLocationWaitingAnimatedIcon>
    with SingleTickerProviderStateMixin {
  bool toggle = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _timer = Timer.periodic(widget.duration, (timer) {
          setState(() {
            toggle = !toggle;
          });
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = toggle
        ? const Icon(Icons.my_location_rounded)
        : const Icon(Icons.location_searching_rounded);
    return icon;
  }
}
