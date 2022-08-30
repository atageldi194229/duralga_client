import 'package:cached_network_image/cached_network_image.dart';
import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppRouteSelectedState) {
          final stopIds = [...state.route.startStops, ...state.route.endStops];

          final stops = state.stops
              .where(
                (e) => stopIds.contains(e.stopId),
              )
              .toList();

          final points1 = state.route.startCoords
              .map(
                (e) => LatLng(
                  double.parse(e[0]),
                  double.parse(e[1]),
                ),
              )
              .toList();

          final points2 = state.route.endCoords
              .map(
                (e) => LatLng(
                  double.parse(e[0]),
                  double.parse(e[1]),
                ),
              )
              .toList();

          return _buildMap(
            stops: stops,
            polylines: [
              Polyline(
                points: points1,
                strokeWidth: 4,
                color: Colors.purple,
              ),
              Polyline(
                points: points2,
                strokeWidth: 4,
                color: Colors.green,
              ),
            ],
          );
        }

        return _buildMap(stops: state.stops.toList());
      },
    );
  }

  _buildMap({
    List<StopModel> stops = const [],
    List<Polyline>? polylines,
  }) {
    final markers = stops
        .map<Marker>(
          (e) => Marker(
            width: 100.0,
            height: 100.0,
            point: LatLng(
              double.parse(e.location[0]),
              double.parse(e.location[1]),
            ),
            builder: (ctx) => const Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
            // builder: (context) => SvgPicture.asset(
            //   "assets/svg/bus_stop.svg",
            //   width: 20,
            //   height: 20,
            // ),
          ),
        )
        .toList();

    return FlutterMap(
      // mapController: myMapController.myMapController,
      options: MapOptions(
        plugins: [MarkerClusterPlugin()],
        center: LatLng(37.862499, 58.238056),
        zoom: 15.0,
        maxZoom: 18.0,
        minZoom: 8.0,
      ),
      layers: [
        TileLayerOptions(
          tileProvider: CachedTileProvider(),
          // urlTemplate: "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          // subdomains: ['a', 'b', 'c'],
          urlTemplate: "http://geo.asmantiz.com/tile/{z}/{x}/{y}.png",
        ),
        if (polylines != null)
          PolylineLayerOptions(
            polylineCulling: false,
            polylines: polylines,
          ),
        MarkerClusterLayerOptions(
          centerMarkerOnClick: true,
          zoomToBoundsOnClick: true,
          maxClusterRadius: 100,
          size: const Size(40, 40),
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
        ),
      ],
    );
  }
}

class CachedTileProvider extends TileProvider {
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      errorListener: () => const Icon(Icons.error),
      getTileUrl(coords, options),
    );
  }
}
