import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class RouteRow extends StatelessWidget {
  const RouteRow(
    this.route, {
    Key? key,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    const count = 3;

    return ListTile(
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
        children: List.generate(
          count,
          (index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding / 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: borderRadius / 2,
                ),
                child: const Text("12m"),
              ),
              if (count > index + 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  child: Text(">"),
                ),
            ],
          ),
        ).toList(),
      ),
    );
  }
}
