import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:duralga_client/extensions/convert_to_lat_lng.dart';
import 'package:flutter/foundation.dart' show immutable, kIsWeb;
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final mapController = MapController();

  bool _permission = false;

  final Location _locationService = Location();

  MapBloc() : super(MapInitial()) {
    on<MapEventLoadCurrentLocation>(
      (event, emit) {
        if (!kIsWeb && Platform.isLinux) {
          return;
        }

        // _initLocationService(event, emit);
      },
    );

    on<MapEventCurrentLocationUpdate>((event, emit) {
      emit(MapState(currentLocation: event.location));

      mapController.move(event.location.latLng, mapController.zoom);
    });

    on<MapEventToggleLiveCurrentLocation>((event, emit) {
      emit(MapState(currentLocation: state.currentLocation, live: !state.live));
    });
  }

  _initLocationService(
    MapEventLoadCurrentLocation event,
    Emitter<MapState> emit,
  ) async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();

          add(MapEventCurrentLocationUpdate(location));

          _locationService.onLocationChanged.listen(
            (result) => add(MapEventCurrentLocationUpdate(result)),
          );
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          _initLocationService(event, emit);
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        // _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        // _serviceError = e.message;
      }
      location = null;
    }
  }
}
