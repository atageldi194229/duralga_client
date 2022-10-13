import 'package:duralga_client/data/models/route_bus_collection_model.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/markers/bus_marker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const List<Color> colors = [
  Colors.black,
  Colors.amber,
  Colors.indigo,
  Colors.teal,
  Colors.red,
  Colors.lime,
];

Iterable<LayerOptions> buildRouteBusesLayers(
    RouteBusCollectionModel collection, RouteModel route) {
  List<Marker> originalBuses = [];
  List<Marker> busesOnTheRoad = [];

  final buses =
      collection.buses.where((bus) => bus.locations.isNotEmpty).toList();

  List<Polyline> polylines = [];

  for (int i = 0; i < buses.length; i++) {
    final bus = buses[i];
    final color = colors[i % colors.length];
    final busLocation = bus.locations.last;
    final point = LatLng(busLocation.point[0], busLocation.point[1]);

    if (bus.isAb == null) continue;

    // debugPrint("length: ${bus.locations.length}");

    // lineString that shows buses last points
    // polylines.add(Polyline(
    //   strokeWidth: 4,
    //   color: color,
    //   points: bus.locations
    //       .map<LatLng>((e) => LatLng(e.point[0], e.point[1]))
    //       .toList(),
    // ));

    originalBuses.add(buildBusMarker(
      point: point,
      selected: true,
      // color: color,
      colorActive: color,
    ));

    late LatLng point2;
    late double bearing;

    if (bus.isAb!) {
      point2 = LatLng(busLocation.ab.point[0], busLocation.ab.point[1]);
      bearing = busLocation.ab.bearing;
    } else {
      point2 = LatLng(busLocation.ba.point[0], busLocation.ba.point[1]);
      bearing = busLocation.ba.bearing;
    }

    busesOnTheRoad.add(buildBusMarker(
      point: point2,
      bearing: bearing,
      tooltip: "${route.number}",
    ));

    // line between original bus and onroad bus
    polylines.add(Polyline(
      strokeWidth: 2,
      color: color,
      points: [point, point2],
    ));
  }

  return [
    if (!kReleaseMode)
      PolylineLayerOptions(
        polylineCulling: false,
        polylines: polylines,
      ),
    MarkerLayerOptions(
      markers: [
        // ...originalBuses,
        ...busesOnTheRoad,
      ],
    ),
  ];
}
