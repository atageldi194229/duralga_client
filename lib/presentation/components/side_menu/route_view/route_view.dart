import 'dart:math';

import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/presentation/components/route_number_widget.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RouteView extends HookWidget {
  const RouteView(
    this.route, {
    Key? key,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final allStops = appBloc.getRouteStops(route);
    final showStart = useState<bool>(true);

    final stops = ((showStart.value ? route.startStops : route.endStops))
        .map<StopModel>(
            (stopId) => allStops.firstWhere((e) => e.stopId == stopId))
        .toList();

    final selectedStop = context.read<AppBloc>().lastSelectedStop;
    int selectedStopIndex = -1;

    if (selectedStop != null) {
      selectedStopIndex = stops.indexOf(selectedStop);
      debugPrint("I AM HEREE $selectedStopIndex");
    }

    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding,
          horizontal: defaultPadding * 2,
        ),
        child: Row(
          children: [
            RouteNumberWidget(route),
            const SizedBox(width: defaultPadding),
            Text(
              route.description.join("-->"),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(defaultPadding).copyWith(
          left: defaultPadding * 3,
        ),
        child: InkWell(
          onTap: () {
            showStart.value = !showStart.value;
          },
          child: Row(
            children: [
              Text("Stops", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: defaultPadding),
              Image.asset("assets/png/up_down_arrow.png"),
            ],
          ),
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
            child: StopListStepper(
              key: Key(Random.secure().nextDouble().toString()),
              stops: stops,
              selectedIndex: selectedStopIndex,
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

class StopListStepper extends StatelessWidget {
  const StopListStepper({
    Key? key,
    required this.stops,
    this.selectedIndex = -1,
  }) : super(key: key);

  final List<StopModel> stops;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const ClampingScrollPhysics(),
      onStepTapped: (value) {
        context.read<AppBloc>().add(AppEventSelectStop(stops.toList()[value]));
      },
      currentStep: 1,
      margin: const EdgeInsets.all(0),
      controlsBuilder: (context, details) => Row(),
      steps: List.generate(stops.length, (index) {
        final stop = stops[index];
        StepState stepState = StepState.indexed;
        bool isActive = false;

        if (index < selectedIndex) {
          stepState = StepState.disabled;
        }

        if (selectedIndex == index) {
          isActive = true;
        }

        return Step(
          title: Column(
            children: [
              Text(
                stop.name,
                style: isActive ? const TextStyle(color: kGreenColor) : null,
              ),
            ],
          ),
          content: const SizedBox(),
          isActive: stepState == StepState.disabled ? false : true,
          state: stepState,
        );
      }),
    );
  }
}
