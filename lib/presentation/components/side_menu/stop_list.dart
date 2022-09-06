import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StopList extends StatelessWidget {
  const StopList({
    Key? key,
    this.scrollController,
  }) : super(key: key);

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (p, c) =>
          p.stops.length != c.stops.length || c is AppStateSearch,
      builder: (context, state) {
        var stops = state.stops.toList();

        if (state is AppStateSearch) {
          // stops = context.read<AppBloc>().getFilteredstopsBySearch(state);
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  StopRow(stops[index]),
                  const Divider(),
                ],
              );
            },
            childCount: stops.length,
          ),
        );
      },
    );
  }
}

class StopRow extends StatelessWidget {
  const StopRow(this.stop, {Key? key}) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    final busStopImagePng = Image.asset("assets/png/bus_stop2.png");

    return InkWell(
      onTap: () {
        context.read<AppBloc>().add(AppEventSelectStop(stop));
      },
      child: ListTile(
        leading: SizedBox(
          width: 40,
          height: 25,
          // alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(
          //   horizontal: defaultPadding,
          //   vertical: defaultPadding / 2,
          // ),
          child: busStopImagePng,
        ),
        title: Text(
          stop.name,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
        ),
      ),
    );
  }
}
