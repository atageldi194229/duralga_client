import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/stop_arrival_time_response_model_2.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/data/repositories/duralga_data_repository.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'route_row.dart';

class StopView extends HookWidget {
  const StopView(this.stop, {Key? key}) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final routes = appBloc.getStopRoutes(stop);

    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/png/bus_stop.png"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 2,
                    ),
                    child: Text(stop.name),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.red,
                  onPressed: () {
                    context.read<AppBloc>().add(AppEventGoToBack());
                  },
                ),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
            Text(
              "Arrival time: ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      FutureBuilder<StopArrivalTimeResponse2>(
        future: DuralgaDataRepository().getStopArrivalTimes3(stop.stopId),
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            final data = snapshot.data!.arrivalTimeByRouteNumber;
            var keys = data.keys.toList();

            keys.sort((a, b) {
              final timesA = data[a];
              final timesB = data[b];

              if (timesA == null || timesA.isEmpty) return 1;
              if (timesB == null || timesB.isEmpty) return 0;

              final firstA = timesA[0];
              final firstB = timesA[0];

              if (firstA == null) return 1;
              if (firstB == null) return 0;

              return firstA.compareTo(firstB);
            });

            for (String key in keys) {
              final times = data[key];
              final routeNumber = int.parse(key);

              if (routes.any((e) => e.number == routeNumber)) {
                final route = routes.firstWhere((e) => e.number == routeNumber);

                children.add(
                  RouteRow(route, times!),
                );
              }
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      // ...routes.map(
      //   (route) => RouteRow(route),
      // ),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return widgets[index];
        },
        childCount: widgets.length,
      ),
    );
  }
}
