import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker buildBusMarker({
  required LatLng point,
  double bearing = 0,
  bool selected = false,
  Color color = Colors.blue,
  Color colorActive = Colors.green,
}) {
  double angle = bearing * pi / 180.0;

  final busMarkerPng = Transform.rotate(
    angle: (selected) ? angle : -angle,
    child: ColorFiltered(
      colorFilter: ColorFilter.mode(
        !selected ? color : colorActive,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        "assets/png/icons8-navigate-96.png",
        // width: 20 * makeBigger,
        // height: 20 * makeBigger,
      ),
    ),
  );

  double makeBigger = selected ? 2.5 : 1.5;
  double size = 20;

  return Marker(
    width: size * makeBigger,
    height: size * makeBigger,
    point: point,
    // rotateOrigin: rotateOrigin,
    // anchorPos: AnchorPos.align(AnchorAlign.top),
    builder: (context) => GestureDetector(
      onTap: () {
        // context.read<AppBloc>().add(AppEventSelectStop(stop));
      },
      child: busMarkerPng,
    ),
  );
}
