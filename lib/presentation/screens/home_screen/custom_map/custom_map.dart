import 'package:duralga_client/bloc/map_bloc/map_bloc.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

final mapOptions = MapOptions(
  plugins: [
    MarkerClusterPlugin(),
    const LocationMarkerPlugin(),
  ],
  center: LatLng(37.938703, 58.382853),
  zoom: 15.0,
  maxZoom: 18.0,
  minZoom: 8.0,
  interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
);

class CustomMap extends StatelessWidget {
  const CustomMap({Key? key, this.layers = const []}) : super(key: key);

  final List<LayerOptions> layers;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: context.read<MapBloc>().mapController,
      options: mapOptions,
      layers: [
        tileLayerOptions,
        // LocationMarkerLayerOptions(),
        ...layers,
      ],
    );
  }
}
