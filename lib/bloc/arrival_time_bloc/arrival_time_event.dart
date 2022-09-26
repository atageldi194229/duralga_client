part of 'arrival_time_bloc.dart';

@immutable
abstract class ArrivalTimeEvent {}

@immutable
class ArrivalTimeEventLoadStopArrivalTimes extends ArrivalTimeEvent {
  final Future<StopArrivalTimeResponse> Function() loader;
  ArrivalTimeEventLoadStopArrivalTimes({
    required this.loader,
  });
}
