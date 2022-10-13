import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

Marker buildBusMarker({
  required LatLng point,
  double bearing = 0,
  bool selected = false,
  Color color = Colors.blue,
  Color colorActive = Colors.green,
  String tooltip = "?",
}) {
  double angle = bearing * pi / 180.0;

  final busMarkerPng = LayoutBuilder(
    builder: (context, constraints) => Stack(
      children: [
        Transform.rotate(
          origin: const Offset(-2, 0),
          angle: selected ? angle : -angle,
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SvgPicture.asset("assets/svg/napravlenie.svg"),
          ),
        ),
        Positioned(
          top: constraints.maxWidth * 0.24,
          left: constraints.maxWidth * 0.15,
          child: SizedBox(
            width: constraints.maxWidth / 2,
            height: constraints.maxHeight / 2,
            child: SvgPicture.asset("assets/svg/awtobus.svg"),
          ),
        ),
      ],
    ),
  );

  double makeBigger = selected ? 2.5 : 1.5;
  double size = 18;

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
      child: Tooltip(
        preferBelow: false,
        message: tooltip,
        child: busMarkerPng,
      ),
    ),
  );
}
