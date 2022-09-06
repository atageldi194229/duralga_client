import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
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
      ...routes.map(
        (route) => RouteRow(route),
      ),
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
