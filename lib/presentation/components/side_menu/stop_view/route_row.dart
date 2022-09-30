import 'dart:math';

import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/presentation/components/route_number_widget.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class RouteRow extends StatelessWidget {
  const RouteRow(
    this.route,
    this.times, {
    Key? key,
  }) : super(key: key);

  final List<double?> times;
  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    int count = min(times.length, 3);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
        vertical: defaultPadding,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RouteNumberWidget(route),
          const SizedBox(width: defaultPadding),
          Text(
            route.description.join(' --->\n'),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              count,
              (index) {
                String text = "---";
                final time = times[index];

                if (time != null && time < 900) {
                  text = (time.toInt() ~/ 60).toString();
                }

                return Row(
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
                      child: Text(text),
                    ),
                    if (count > index + 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: Text(">"),
                      ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );

    // return ListTile(
    //   leading: Container(
    //     width: 40,
    //     height: 25,
    //     // alignment: Alignment.center,
    //     // padding: const EdgeInsets.symmetric(
    //     //   horizontal: defaultPadding,
    //     //   vertical: defaultPadding / 2,
    //     // ),
    //     decoration: const BoxDecoration(
    //       color: Colors.blue,
    //       borderRadius: borderRadius,
    //     ),
    //     child: InkWell(
    //       onTap: () {
    //         context.read<AppBloc>().add(AppEventSelectRoute(route));
    //       },
    //       child: Center(
    //         child: Text(
    //           "${route.number}",
    //           style: const TextStyle(color: Colors.white),
    //         ),
    //       ),
    //     ),
    //   ),
    //   title: Text(
    //     route.description.join(' --->\n'),
    //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
    //           color: Theme.of(context).textTheme.bodyLarge!.color,
    //         ),
    //   ),
    //   trailing: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: List.generate(
    //       count,
    //       (index) {
    //         String text = "---";

    //         // if (times.length > index) {
    //         text = times[index].t.toString();
    //         // }

    //         return Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.all(defaultPadding / 2),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.blue,
    //                 ),
    //                 borderRadius: borderRadius / 2,
    //               ),
    //               child: Text(text),
    //             ),
    //             if (count > index + 1)
    //               const Padding(
    //                 padding:
    //                     EdgeInsets.symmetric(horizontal: defaultPadding / 2),
    //                 child: Text(">"),
    //               ),
    //           ],
    //         );
    //       },
    //     ).toList(),
    //   ),
    // );
  }
}
