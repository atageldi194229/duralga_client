import 'package:duralga_client/data/models/stop_model.dart';
import 'package:flutter_map/flutter_map.dart';

import '../markers/bus_stop_marker.dart';

LayerOptions buildStopsLayer(Iterable<StopModel> stops) {
  List<Marker> markers = [];

  final stopList = stops.toList();

  for (var i = 0; i < stopList.length; i++) {
    markers.add(buildBusStopMarker(stopList[i], tooltip: stopList[i].name));
  }

  return MarkerLayerOptions(
    markers: markers,
  );
}
