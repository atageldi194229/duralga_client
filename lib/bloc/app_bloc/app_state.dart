// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

@immutable
class AppState {
  final Iterable<StopModel> stops;
  final Iterable<RouteModel> routes;
  final LatLng? currentLocation;

  const AppState({
    required this.stops,
    required this.routes,
    this.currentLocation,
  });

  AppState copyWith({
    Iterable<StopModel>? stops,
    Iterable<RouteModel>? routes,
    LatLng? currentLocation,
  }) {
    return AppState(
      stops: stops ?? this.stops,
      routes: routes ?? this.routes,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.stops == stops &&
        other.routes == routes &&
        other.currentLocation == currentLocation;
  }

  @override
  int get hashCode => Object.hash(
        stops.hashCode,
        routes.hashCode,
        currentLocation.hashCode,
      );
}

class AppInitial extends AppState {
  AppInitial()
      : super(
          stops: [],
          routes: [],
        );
}
