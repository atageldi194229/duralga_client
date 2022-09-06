part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

@immutable
class AppEventLoadData extends AppEvent {}

@immutable
class AppEventSelectRoute extends AppEvent {
  final RouteModel route;
  AppEventSelectRoute(this.route);
}

@immutable
class AppEventSelectStop extends AppEvent {
  final StopModel stop;
  AppEventSelectStop(this.stop);
}

@immutable
class AppEventGoToRouteList extends AppEvent {}

@immutable
class AppEventGoToStopList extends AppEvent {}

@immutable
class AppEventGoToBack extends AppEvent {}

@immutable
class AppEventSearch extends AppEvent {
  final String search;
  AppEventSearch(this.search);
}
