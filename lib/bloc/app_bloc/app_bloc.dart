import 'package:dio/dio.dart';
import 'package:duralga_client/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:duralga_client/bloc/loading_bloc/loading_bloc.dart';
import 'package:duralga_client/data/errors/app_error.dart';
import 'package:duralga_client/data/models/duralga_data_model.dart';
import 'package:duralga_client/data/models/route_bus_collection_model.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/data/repositories/duralga_data_repository.dart';
import 'package:duralga_client/utils/bloc_navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:string_similarity/string_similarity.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppErrorBloc appErrorBloc;
  final LoadingBloc loadingBloc;

  final BlocNavigator _navigator = BlocNavigator(CustomRouter(
    AppState,
    [
      CustomRouter(AppStateRouteList, [
        CustomRouter(AppStateRouteSelected, [
          CustomRouter(AppStateStopSelected),
        ]),
      ]),
      CustomRouter(AppStateStopList, [
        CustomRouter(AppStateStopSelected, [
          CustomRouter(AppStateRouteSelected),
        ]),
      ]),
      CustomRouter(AppStateSearch),
    ],
  ));

  Map<int, List<RouteModel>> stopRoutesMap = {};

  AppBloc({
    required this.appErrorBloc,
    required this.loadingBloc,
  }) : super(AppInitial()) {
    on<AppEventLoadData>((event, emit) async {
      try {
        // start loading
        loadingBloc.add(const StartLoadingEvent());

        final data = await DuralgaDataRepository().getData();

        data.routes.sort((a, b) => a.number.compareTo(b.number));

        final state = BaseAppState(
          stops: data.stops,
          routes: data.routes,
        );

        emit(_navigator.push(
          AppStateRouteList(state: state),
        ));

        // stop loading
        loadingBloc.add(const StopLoadingEvent());

        generateStopRoutesMap(data);

        return;
      } on DioError catch (_) {
      } catch (error) {
        debugPrint(error.toString());
      }

      // stop loading & show load error dialog
      loadingBloc.add(const StopLoadingEvent());
      appErrorBloc.add(const AppErrorAddEvent(LoadError()));
    });

    on<AppEventSelectRoute>((event, emit) async {
      emit(_navigator.push(AppStateRouteSelected(
        state: state,
        route: event.route,
      )));

      try {
        final data = await DuralgaDataRepository()
            .getRouteBusCollection(event.route.number);

        emit(_navigator.push(AppStateRouteSelected(
          state: state,
          route: event.route,
          busCollection: data,
        )));
      } catch (_) {
        appErrorBloc.add(const AppErrorAddEvent(LoadError()));
      }
    });

    on<AppEventSelectStop>((event, emit) {
      emit(_navigator.push(AppStateStopSelected(
        state: state,
        stop: event.stop,
      )));
    });

    on<AppEventGoToRouteList>((event, emit) {
      emit(_navigator.push(AppStateRouteList(state: state)));
    });

    on<AppEventGoToStopList>((event, emit) {
      emit(_navigator.push(AppStateStopList(state: state)));
    });

    on<AppEventGoToBack>((event, emit) => emit(_navigator.pop()));

    on<AppEventSearch>((event, emit) {
      emit(AppStateSearch(
        search: event.search,
        state: state,
      ));
    });
  }

  generateStopRoutesMap(DuralgaDataModel data) {
    Map<int, List<RouteModel>> m = {};

    for (var route in data.routes) {
      final stopIds = [...route.startStops, ...route.endStops];

      for (var stopId in stopIds) {
        if (!m.containsKey(stopId) || m[stopId] == null) {
          m[stopId] = [];
        }

        m[stopId]!.add(route);
      }
    }

    stopRoutesMap = m;
  }

  List<RouteModel> getFilteredRoutesBySearch(AppStateSearch state) {
    final search = state.search.toLowerCase();

    if (search.isEmpty) {
      return state.routes.toList();
    }

    if (int.tryParse(search) != null) {
      return state.routes
          .where((e) => e.number.toString().startsWith(search))
          .toList();
    }

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
  }

  List<StopModel> getRouteStops(RouteModel route) {
    return state.stops
        .where((e) =>
            route.startStops.contains(e.stopId) ||
            route.endStops.contains(e.stopId))
        .toList();
  }

  List<RouteModel> getStopRoutes(StopModel stop) {
    return stopRoutesMap.containsKey(stop.stopId)
        ? stopRoutesMap[stop.stopId]!
        : [];
  }

  // Future<LatLng?> getCurrentLocation() async {
  //   Location location = Location();

  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return null;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }

  //   locationData = await location.getLocation();

  //   return LatLng(locationData.latitude!, locationData.longitude!);
  // }
}
