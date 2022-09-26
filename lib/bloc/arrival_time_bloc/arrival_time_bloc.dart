import 'package:bloc/bloc.dart';
import 'package:duralga_client/data/models/stop_arrival_time_response_model.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'arrival_time_event.dart';
part 'arrival_time_state.dart';

class ArrivalTimeBloc extends Bloc<ArrivalTimeEvent, ArrivalTimeState> {
  ArrivalTimeBloc() : super(ArrivalTimeInitial()) {
    on<ArrivalTimeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
