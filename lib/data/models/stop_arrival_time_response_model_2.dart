import 'dart:convert';

import 'package:duralga_client/data/models/stop_model.dart';

class StopArrivalTimeResponse2 {
  StopArrivalTimeResponse2({
    required this.stop,
    required this.arrivalTimeByRouteNumber,
  });

  final StopModel stop;
  final Map<String, List<double?>> arrivalTimeByRouteNumber;

  factory StopArrivalTimeResponse2.fromJson(String str) =>
      StopArrivalTimeResponse2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StopArrivalTimeResponse2.fromMap(Map<String, dynamic> json) =>
      StopArrivalTimeResponse2(
        stop: StopModel.fromMap(json["stop"]),
        arrivalTimeByRouteNumber: Map.from(json["arrivalTimeByRouteNumber"])
            .map((k, v) => MapEntry<String, List<double?>>(
                k, List<double?>.from(v.map((x) => x?.toDouble())))),
      );

  Map<String, dynamic> toMap() => {
        "stop": stop.toMap(),
        "arrivalTimeByRouteNumber": Map.from(arrivalTimeByRouteNumber).map((k,
                v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
      };
}
