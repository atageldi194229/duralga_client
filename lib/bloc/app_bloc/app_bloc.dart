import 'package:duralga_client/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:duralga_client/bloc/loading_bloc/loading_bloc.dart';
import 'package:duralga_client/data/errors/app_error.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/data/repositories/duralga_data_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppErrorBloc appErrorBloc;
  final LoadingBloc loadingBloc;

  AppBloc({
    required this.appErrorBloc,
    required this.loadingBloc,
  }) : super(AppInitial()) {
    on<LoadDataAppEvent>((event, emit) async {
      try {
        // start loading
        loadingBloc.add(const StartLoadingEvent());

        final data = await DuralgaDataRepository().getData();

        emit(state.copyWith(
          stops: data.stops,
          routes: data.routes,
        ));

        // stop loading
        loadingBloc.add(const StopLoadingEvent());
      } catch (_) {
        // stop loading & show load error dialog
        loadingBloc.add(const StopLoadingEvent());
        appErrorBloc.add(const AppErrorAddEvent(LoadError()));
      }
    });
  }
}
