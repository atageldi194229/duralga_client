// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

@immutable
class AppState {
  final Iterable<StopModel> stops;
  final Iterable<RouteModel> routes;

  const AppState({
    required this.stops,
    required this.routes,
  });

  AppState copyWith({
    Iterable<StopModel>? stops,
    Iterable<RouteModel>? routes,
  }) {
    return AppState(
      stops: stops ?? this.stops,
      routes: routes ?? this.routes,
    );
  }

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.stops == stops && other.routes == routes;
  }

  @override
  int get hashCode => stops.hashCode ^ routes.hashCode;
}

class AppInitial extends AppState {
  AppInitial()
      : super(
          stops: [],
          routes: [],
        );
}
