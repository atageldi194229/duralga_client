import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/bloc/map_bloc/map_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
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
  late final MapController _mapController;

  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();

    _mapController = MapController();
  }

  void updateCurrentLocation(LocationData result) async {
    if (mounted) {
      setState(() {
        _currentLocation = result;

        debugPrint("Current Location: ${[
          result.latitude,
          result.longitude,
        ]}");

        // If Live Update is enabled, move map center
        _mapController.move(
          LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          _mapController.zoom,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        animatedMapMove(
          mapController: context.read<MapBloc>().mapController,
          destLocation: state.currentLocation!.latLng,
          vsync: this,
          duration: const Duration(seconds: 3),
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
              );

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

            if (state is AppStateStopSelected) {
              return _buildMap(
                stops: [state.stop],
                center: LatLng(
                  double.parse(state.stop.location[0]),
                  double.parse(state.stop.location[1]),
                ),
                zoom: 17,
              );
            }

            return _buildMap(stops: state.stops.toList());
          },
        );
      },
    );
  }

  _buildMap({
    List<StopModel> stops = const [],
    List<Polyline>? polylines,
    LatLng? center,
    double zoom = 15.0,
  }) {
    final busStopMarkerPng = Image.asset(
      "assets/png/bus_stop.png",
      width: 20,
      height: 20,
    );

    final markers = stops.map<Marker>((e) {
      final point = LatLng(
        double.parse(e.location[0]),
        double.parse(e.location[1]),
      );

      return Marker(
        point: point,
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (context) => GestureDetector(
          onTap: () {
            debugPrint(point.toString());
          },
          child: busStopMarkerPng,
        ),
      );
    }).toList();

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
          size: const Size(40, 40),
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
