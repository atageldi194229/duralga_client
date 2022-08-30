import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/bloc/app_error_bloc/app_error_bloc.dart';
import 'package:duralga_client/bloc/loading_bloc/loading_bloc.dart';
import 'package:duralga_client/presentation/components/dialogs/show_app_error.dart';
import 'package:duralga_client/presentation/components/loading/loading_screen.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:duralga_client/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "Duralga Client",
        theme: ThemeData.dark(),
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoadingBloc, LoadState>(
                listener: (_, state) {
                  if (state is LoadStateOn) {
                    LoadingScreen.instance().show(
                      navigatorKey: navigatorKey,
                      text: "Loading",
                    );
                  } else {
                    LoadingScreen.instance().hide();
                  }
                },
              ),
              BlocListener<AppErrorBloc, AppErrorState>(
                listener: (context, state) {
                  if (state.error != null) {
                    final error = state.error!;

                    showAppError(
                      error: error,
                      context: navigatorKey.currentContext!,
                    ).then((value) {
                      context
                          .read<AppErrorBloc>()
                          .add(AppErrorRemoveEvent(error));
                    });
                  }
                },
              ),
            ],
            child: child!,
          );
        },

        home: const HomeScreen(),
        // home: const TestScreen(),
      ),
    );
  }

  List<BlocProvider> _getProviders() {
    final loadingBloc = LoadingBloc();
    final appErrorBloc = AppErrorBloc();

    final appBloc = AppBloc(
      appErrorBloc: appErrorBloc,
      loadingBloc: loadingBloc,
    );

    appBloc.add(AppEventLoadData());

    return [
      BlocProvider<LoadingBloc>(create: (_) => loadingBloc),
      BlocProvider<AppErrorBloc>(create: (_) => appErrorBloc),
      BlocProvider<AppBloc>(create: (_) => appBloc),
    ];
  }
}
