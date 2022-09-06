import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RouteView extends HookWidget {
  const RouteView(this.route, {Key? key}) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final allStops = appBloc.getRouteStops(route);
    final showStart = useState<bool>(true);

    final stops = ((showStart.value ? route.startStops : route.endStops))
        .map<StopModel>(
            (stopId) => allStops.firstWhere((e) => e.stopId == stopId));

    final widgets = <Widget>[
      Container(
        padding: const EdgeInsets.all(defaultPadding).copyWith(
          left: defaultPadding * 3,
        ),
        child: Row(
          children: [
            Text("Stops", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(width: defaultPadding),
            Image.asset("assets/png/up_down_arrow.png"),
          ],
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: defaultPadding * 3,
              left: defaultPadding * 3,
            ),
            child: Image.asset(
              "assets/png/arrow_down.png",
              // width: 20,
              // height: 20,
            ),
          ),
          Expanded(
            child: Stepper(
              currentStep: 1,
              margin: const EdgeInsets.all(0),
              controlsBuilder: (context, details) => Row(),
              steps: stops.map((e) {
                return Step(
                  title: Text(e.name),
                  content: const SizedBox(),
                  isActive: true,
                );
              }).toList(),
            ),
          ),
        ],
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
