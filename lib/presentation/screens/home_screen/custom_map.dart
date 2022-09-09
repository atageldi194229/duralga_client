import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/bloc/map_bloc/map_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/extensions/convert_stop_model_location_to_lat_lng.dart';
import 'package:duralga_client/presentation/animations/animated_map_move.dart';
import 'package:duralga_client/extensions/location_data_to_lat_lng_converter.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  LocationData? _currentLocation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        animatedMapMove(
          mapController: context.read<MapBloc>().mapController,
          destLocation: state.currentLocation!.latLng,
          vsync: this,
          duration: const Duration(seconds: 1),
        );
      },
      builder: (context, state) {
        return BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppStateRouteSelected) {
              final stopIds = [
                ...state.route.startStops,
                ...state.route.endStops
              ];

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

              animatedMapMove(
                mapController: context.read<MapBloc>().mapController,
                destLocation: points1.first,
                vsync: this,
                duration: const Duration(seconds: 1),
              );

              return _buildMap(
                markers: stops.map<Marker>(_buildStopMarker),
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

            if (state is AppStateStopSelected) {
              animatedMapMove(
                mapController: context.read<MapBloc>().mapController,
                destLocation: state.stop.latLng,
                vsync: this,
                duration: const Duration(seconds: 1),
                destZoom: 16,
              );

              return _buildMap(
                markers: state.stops.map<Marker>((stop) {
                  if (stop.id == state.stop.id) {
                    return _buildStopMarker(stop, selected: true);
                  }
                  return _buildStopMarker(stop);
                }),
                center: state.stop.latLng,
                zoom: 17,
              );
            }

            return _buildMap(
              markers: state.stops.map<Marker>(_buildStopMarker),
            );
          },
        );
      },
    );
  }

  Marker _buildStopMarker(
    StopModel stop, {
    bool selected = false,
  }) {
    final busStopMarkerPng = ColorFiltered(
      colorFilter: ColorFilter.mode(
        !selected ? Colors.blue : Colors.green,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        "assets/png/bus_stop.png",
        // width: 20 * makeBigger,
        // height: 20 * makeBigger,
      ),
    );

    double makeBigger = selected ? 2.5 : 1.5;

    return Marker(
      width: 15 * makeBigger,
      height: 15 * makeBigger,
      point: stop.latLng,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (context) => GestureDetector(
        onTap: () {
          context.read<AppBloc>().add(AppEventSelectStop(stop));
        },
        child: busStopMarkerPng,
      ),
    );
  }

  _buildMap({
    Iterable<Marker> markers = const [],
    List<Polyline>? polylines,
    LatLng? center,
    double zoom = 15.0,
  }) {
    Marker? currentLocationMarker;
    LayerOptions? currentLocationLayerOptions;

    if (_currentLocation != null) {
      LatLng point = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );

      currentLocationLayerOptions = CircleLayerOptions(
        circles: [
          CircleMarker(
            //radius marker
            point: point,
            color: Colors.blue.withOpacity(0.3),
            borderStrokeWidth: 3.0,
            borderColor: Colors.blue,
            radius: 150, //radius
          ),
        ],
      );

      currentLocationMarker = Marker(
        point: point,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const FlutterLogo(
              size: 20,
              textColor: Colors.blue,
              key: ObjectKey(Colors.blue),
            ),
          );
        },
      );
    }

    return FlutterMap(
      mapController: context.read<MapBloc>().mapController,
      options: MapOptions(
        plugins: [MarkerClusterPlugin()],
        center: center ?? LatLng(37.938703, 58.382853),
        zoom: zoom,
        maxZoom: 18.0,
        minZoom: 8.0,
      ),
      layers: [
        tileLayerOptions,
        if (polylines != null)
          PolylineLayerOptions(
            polylineCulling: false,
            polylines: polylines,
          ),
        MarkerClusterLayerOptions(
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
          markers: markers.toList(),
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
        if (currentLocationLayerOptions != null) currentLocationLayerOptions,
        MarkerLayerOptions(
          markers: [
            if (currentLocationMarker != null) currentLocationMarker,
          ],
        ),
      ],
    );
  }
}
