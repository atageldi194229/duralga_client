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
import 'package:string_similarity/string_similarity.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppErrorBloc appErrorBloc;
  final LoadingBloc loadingBloc;

  AppBloc({
    required this.appErrorBloc,
    required this.loadingBloc,
  }) : super(AppInitial()) {
    on<AppEventLoadData>((event, emit) async {
      try {
        // final currentLocation = await getCurrentLocation();

        // start loading
        loadingBloc.add(const StartLoadingEvent());

        final data = await DuralgaDataRepository().getData();

        emit(AppState(
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

    on<AppEventSelectRoute>((event, emit) {
      emit(AppRouteSelectedState(
        stops: state.stops,
        routes: state.routes,
        route: event.route,
      ));
    });

    on<AppEventSearch>((event, emit) {
      emit(AppStateSearch(event.search, state));
    });
  }

  List<RouteModel> getFilteredRoutesBySearch(AppStateSearch state) {
    final search = state.search.toLowerCase();

    var arr = state.routes
        .map((e) => [
              StringSimilarity.compareTwoStrings(
                search,
                e.number.toString() + e.description.join(),
              ),
              e,
            ])
        .toList();

    arr.sort((a, b) => (b[0] as double).compareTo(a[0] as double));

    return arr.map<RouteModel>((e) => (e[1] as RouteModel)).toList();

    // return state.routes.where((e) {
    //   return e.number.toString().contains(search) ||
    //       e.description.join("").toLowerCase().contains(search);
    // }).toList();
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
