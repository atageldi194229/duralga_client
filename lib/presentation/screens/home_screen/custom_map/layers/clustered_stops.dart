import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../markers/bus_stop_marker.dart';

LayerOptions buildClusteredStopsLayer(Iterable<StopModel> stops) {
  final markers = stops.map(buildBusStopMarker).toList();

  return MarkerClusterLayerOptions(
    centerMarkerOnClick: true,
    zoomToBoundsOnClick: true,
    maxClusterRadius: 100,
    size: const Size(20, 20),
    disableClusteringAtZoom: 15,
    fitBoundsOptions: const FitBoundsOptions(
      padding: EdgeInsets.all(defaultPadding * 6),
    ),
    animationsOptions: const AnimationsOptions(
      // centerMarker: Duration(seconds: 0),
      // fitBound: Duration(seconds: 0),
      spiderfy: Duration(seconds: 0),
      zoom: Duration(seconds: 0),
    ),
    markers: markers,
    polygonOptions: const PolygonOptions(
      // borderColor: kBlueColor,
      color: Colors.black12,
      borderStrokeWidth: 3,
    ),
    builder: (context, markers) {
      return FloatingActionButton(
        onPressed: null,
        child: Text(markers.length.toString()),
      );
    },
  );
}
