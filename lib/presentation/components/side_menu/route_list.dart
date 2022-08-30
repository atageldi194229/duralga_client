import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class RouteList extends StatelessWidget {
  const RouteList(
    this.routes, {
    Key? key,
    this.scrollController,
  }) : super(key: key);

  final List<RouteModel> routes;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return RouteRow(routes[index]);
        },
        childCount: routes.length,
      ),
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
        onTap: () {},
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
