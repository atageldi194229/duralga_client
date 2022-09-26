part of 'map_bloc.dart';

@immutable
class MapState {
  final LocationData? currentLocation;
  final bool live;

  const MapState({
    this.currentLocation,
    this.live = false,
  });
}

class MapInitial extends MapState {}
