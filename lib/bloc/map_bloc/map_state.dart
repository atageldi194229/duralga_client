part of 'map_bloc.dart';

@immutable
class MapState {
  final LocationData? currentLocation;

  const MapState({
    this.currentLocation,
  });
}

class MapInitial extends MapState {}
