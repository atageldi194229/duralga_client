import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteNumberWidget extends StatelessWidget {
  const RouteNumberWidget(
    this.route, {
    Key? key,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: InkWell(
        onTap: () {
          context.read<AppBloc>().add(AppEventSelectRoute(route));
        },
        child: Center(
          child: Text(
            "${route.number}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
