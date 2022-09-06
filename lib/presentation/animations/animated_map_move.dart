import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void animatedMapMove({
  required MapController mapController,
  required LatLng destLocation,
  double? destZoom,
  required TickerProvider vsync,
  Duration duration = const Duration(microseconds: 500),
}) {
  // Create some tweens. These serve to split up the transition from one location to another.
  // In our case, we want to split the transition be<tween> our current map center and the destination.
  final latTween = Tween<double>(
    begin: mapController.center.latitude,
    end: destLocation.latitude,
  );
  final lngTween = Tween<double>(
    begin: mapController.center.longitude,
    end: destLocation.longitude,
  );
  final zoomTween = Tween<double>(
    begin: mapController.zoom,
    end: destZoom ?? mapController.zoom,
  );

  // Create a animation controller that has a duration and a TickerProvider.
  final controller = AnimationController(
    duration: duration,
    vsync: vsync,
  );
  // The animation determines what path the animation will take. You can try different Curves values, although I found
  // fastOutSlowIn to be my favorite.
  final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.fastOutSlowIn,
  );

  controller.addListener(() {
    mapController.move(
      LatLng(
        latTween.evaluate(animation),
        lngTween.evaluate(animation),
      ),
      zoomTween.evaluate(animation),
    );
  });

  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      controller.dispose();
    } else if (status == AnimationStatus.dismissed) {
      controller.dispose();
    }
  });

  controller.forward();
}
