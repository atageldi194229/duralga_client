// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

@immutable
class BaseAppState {
  final Iterable<StopModel> stops;
  final Iterable<RouteModel> routes;

  const BaseAppState({
    required this.stops,
    required this.routes,
  });
}

@immutable
class AppState extends BaseAppState {
  AppState(BaseAppState state)
      : super(
          routes: state.routes,
          stops: state.stops,
        );
}

@immutable
class AppStateRouteList extends AppState {
  AppStateRouteList({
    required BaseAppState state,
  }) : super(state);
}

@immutable
class AppStateStopList extends AppState {
  AppStateStopList({
    required BaseAppState state,
  }) : super(state);
}

@immutable
class AppStateRouteSelected extends AppStateRouteList {
  final RouteModel route;

  AppStateRouteSelected({
    required super.state,
    required this.route,
  });
}

@immutable
class AppStateRouteSelectedBuses extends AppStateRouteSelected {
  final RouteBusCollectionModel busCollection;

  AppStateRouteSelectedBuses({
    required super.state,
    required super.route,
    required this.busCollection,
  });
}

@immutable
class AppStateStopSelected extends AppStateStopList {
  final StopModel stop;
  final Iterable<LatLng> buses;

  AppStateStopSelected({
    required super.state,
    required this.stop,
    this.buses = const [],
  });
}

@immutable
class AppStateSearch extends AppState {
  final String search;
  AppStateSearch({
    required this.search,
    required BaseAppState state,
  }) : super(state);
}

@immutable
class AppInitial extends AppState {
  AppInitial()
      : super(const BaseAppState(
          stops: [],
          routes: [],
        ));
}
