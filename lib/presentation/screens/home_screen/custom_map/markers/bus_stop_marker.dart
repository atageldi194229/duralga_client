import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/extensions/convert_stop_model_location_to_lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';

Marker buildBusStopMarker(
  StopModel stop, {
  bool selected = false,
  String tooltip = "?",
}) {
  final busStopMarkerPng =
      SvgPicture.asset("assets/svg/ostanowka_location.svg");
  // child: Image.asset(
  //   "assets/png/bus_stop.png",
  //   // width: 20 * makeBigger,
  //   // height: 20 * makeBigger,
  // ),

  double makeBigger = selected ? 2.5 : 1.5;

  return Marker(
    width: 15 * makeBigger,
    height: 15 * makeBigger,
    point: stop.latLng,
    anchorPos: AnchorPos.align(AnchorAlign.top),
    builder: (context) => GestureDetector(
      onTap: () {
        context.read<AppBloc>().add(AppEventSelectStop(stop));
      },
      child: Tooltip(
        message: tooltip,
        child: busStopMarkerPng,
      ),
    ),
  );
}
