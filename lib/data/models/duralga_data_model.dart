import 'dart:convert';

import 'package:duralga_client/data/models/route_model.dart';
import 'package:duralga_client/data/models/stop_model.dart';

class DuralgaDataModel {
  DuralgaDataModel({
    required this.stops,
    required this.routes,
  });

  final List<StopModel> stops;
  final List<RouteModel> routes;

  factory DuralgaDataModel.fromJson(String str) =>
      DuralgaDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DuralgaDataModel.fromMap(Map<String, dynamic> json) =>
      DuralgaDataModel(
        stops: List<StopModel>.from(
            json["stops"].map((x) => StopModel.fromMap(x))),
        routes: List<RouteModel>.from(
            json["routes"].map((x) => RouteModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "stops": List<dynamic>.from(stops.map((x) => x.toMap())),
        "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
      };
}
