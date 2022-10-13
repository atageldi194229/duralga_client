import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/data/models/stop_model.dart';
import 'package:duralga_client/extensions/convert_stop_model_location_to_lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';

Marker buildIAmHereMarker(
  StopModel stop, {
  String tooltip = "I am here",
}) {
  final busStopMarkerPng = SvgPicture.asset("assets/svg/i_am_here.svg");

  return Marker(
    width: 30,
    height: 30,
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
