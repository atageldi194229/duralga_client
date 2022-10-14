import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/bloc/map_bloc/map_bloc.dart';
import 'package:duralga_client/extensions/convert_stop_model_location_to_lat_lng.dart';
import 'package:duralga_client/presentation/animations/animated_map_move.dart';
import 'package:duralga_client/extensions/convert_to_lat_lng.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/custom_map.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/layers/bus_collection_layers.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/layers/clustered_stops.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/layers/route_layer.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/layers/stops_layer.dart';
import 'package:duralga_client/presentation/screens/home_screen/custom_map/markers/i_am_here_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

class CustomMapBody extends StatefulWidget {
  const CustomMapBody({Key? key}) : super(key: key);

  @override
  State<CustomMapBody> createState() => _CustomMapBodyState();
}

class _CustomMapBodyState extends State<CustomMapBody>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        debugPrint(state.live.toString());
        if (state.live && state.currentLocation != null) {
          animatedMapMove(
            mapController: context.read<MapBloc>().mapController,
            destLocation: state.currentLocation!.latLng,
            vsync: this,
            destZoom: 16,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.currentLocation == current.currentLocation,
      builder: (context, mapBlocState) => BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppStateRouteSelected) {
            List<LayerOptions> layers = [];

            final stopIds = [
              ...state.route.startStops,
              ...state.route.endStops
            ];

            // final startStops = state.stops
            //     .where(
            //       (e) => state.route.startStops.contains(e.stopId),
            //     )
            //     .toList();

            final stops = state.stops
                .where(
                  (e) => stopIds.contains(e.stopId),
                )
                .toList();

            if (state is! AppStateRouteSelectedBuses) {
              animatedMapMove(
                mapController: context.read<MapBloc>().mapController,
                destLocation: stops.first.latLng,
                vsync: this,
                duration: const Duration(seconds: 1),
              );
            }

            final lastSelectedStop = context.read<AppBloc>().lastSelectedStop;

            layers.addAll([
              buildRouteLayer(state.route),
              buildStopsLayer(stops),
            ]);

            if (lastSelectedStop != null) {
              layers.add(MarkerLayerOptions(
                markers: [
                  buildIAmHereMarker(lastSelectedStop),
                ],
              ));
            }

            if (state is AppStateRouteSelectedBuses) {
              layers.addAll(
                buildRouteBusesLayers(state.busCollection, state.route),
              );
            }

            return CustomMap(
              layers: layers,
              // if (state.busCollection == null)
              // buildClusteredStopsLayer(stops),
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

            // final stops = state.stops.where((stop) => stop.id != state.stop.id);
            final routes = context.read<AppBloc>().getStopRoutes(state.stop);

            return CustomMap(
              layers: [
                // buildClusteredStopsLayer(stops),
                ...routes.map((r) => buildRouteLayer(r)),
                MarkerLayerOptions(
                  markers: [
                    buildIAmHereMarker(state.stop),
                  ],
                ),
              ],
            );
          }

          return CustomMap(
            layers: [
              buildClusteredStopsLayer(state.stops),
            ],
          );
        },
      ),
    );
  }
}
