import 'package:duralga_client/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:duralga_client/bloc/loading_bloc/loading_bloc.dart';
import 'package:duralga_client/data/errors/app_error.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/data/repositories/duralga_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppErrorBloc appErrorBloc;
  final LoadingBloc loadingBloc;

  AppBloc({
    required this.appErrorBloc,
    required this.loadingBloc,
  }) : super(AppInitial()) {
    on<LoadDataAppEvent>((event, emit) async {
      try {
        // final currentLocation = await getCurrentLocation();

        // start loading
        loadingBloc.add(const StartLoadingEvent());

        final data = await DuralgaDataRepository().getData();

        emit(state.copyWith(
          stops: data.stops,
          routes: data.routes,
          // currentLocation: currentLocation,
        ));

        // stop loading
        loadingBloc.add(const StopLoadingEvent());
      } catch (error) {
        debugPrint(error.toString());
        // stop loading & show load error dialog
        loadingBloc.add(const StopLoadingEvent());
        appErrorBloc.add(const AppErrorAddEvent(LoadError()));
      }
    });
  }

  Future<LatLng?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();

    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
