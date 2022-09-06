part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

@immutable
class MapEventLoadCurrentLocation extends MapEvent {}

@immutable
class MapEventCurrentLocationUpdate extends MapEvent {
  final LocationData location;
  MapEventCurrentLocationUpdate(this.location);
}
