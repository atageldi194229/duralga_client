import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteList extends StatelessWidget {
  const RouteList({
    Key? key,
    this.scrollController,
  }) : super(key: key);

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (p, c) =>
          p.routes.length != c.routes.length || c is AppStateSearch,
      builder: (context, state) {
        var routes = state.routes.toList();

        if (state is AppStateSearch) {
          routes = context.read<AppBloc>().getFilteredRoutesBySearch(state);
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  RouteRow(routes[index]),
                  const Divider(),
                ],
              );
            },
            childCount: routes.length,
          ),
        );
      },
    );
  }
}

class RouteRow extends StatelessWidget {
  const RouteRow(this.route, {Key? key}) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AppBloc>().add(AppEventSelectRoute(route));
      },
      child: ListTile(
        leading: Container(
          width: 40,
          height: 25,
          // alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(
          //   horizontal: defaultPadding,
          //   vertical: defaultPadding / 2,
          // ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: borderRadius,
          ),
          child: Center(
            child: Text(
              "${route.number}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        title: Text(
          route.description.join(' --->\n'),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Interval",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: defaultPadding),
            Container(
              padding: const EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: borderRadius / 2,
              ),
              child: const Text("12m"),
            )
          ],
        ),
      ),
    );
  }
}
