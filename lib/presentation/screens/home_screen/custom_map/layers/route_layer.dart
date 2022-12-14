import 'package:duralga_client/data/models/route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

LayerOptions buildRouteLayer(
  RouteModel route, {
  bool showStart = true,
  bool showEnd = true,
}) {
  final startPoints = route.startCoords
      .map(
        (e) => LatLng(
          double.parse(e[0]),
          double.parse(e[1]),
        ),
      )
      .toList();

  final endPoints = route.endCoords
      .map(
        (e) => LatLng(
          double.parse(e[0]),
          double.parse(e[1]),
        ),
      )
      .toList();

  final polylines = [
    if (showStart)
      Polyline(
        points: startPoints.toList(),
        strokeWidth: 4,
        color: Colors.blueAccent,
      ),
    if (showEnd)
      Polyline(
        points: endPoints.toList(),
        strokeWidth: 4,
        color: Colors.purple,
      ),
  ];

  return PolylineLayerOptions(
    polylineCulling: false,
    polylines: polylines,
  );
}
