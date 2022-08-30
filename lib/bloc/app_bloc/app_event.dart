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
