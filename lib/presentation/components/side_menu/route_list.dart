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
      buildWhen: (p, c) => p.routes.length != c.routes.length,
      builder: (context, state) {
        final routes = state.routes.toList();

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return RouteRow(routes[index]);
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
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.read<AppBloc>().add(AppEventSelectRoute(route));
        },
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: borderRadius,
            ),
            child: Text("${route.number}"),
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
                padding: const EdgeInsets.all(defaultPadding),
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
      ),
    );
  }
}
