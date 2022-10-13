import 'dart:convert';

class RouteTimeIntervalsResponse {
  RouteTimeIntervalsResponse({
    required this.routeTimeIntervals,
  });

  final Map<String, double> routeTimeIntervals;

  factory RouteTimeIntervalsResponse.fromJson(String str) =>
      RouteTimeIntervalsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RouteTimeIntervalsResponse.fromMap(Map<String, dynamic> json) =>
      RouteTimeIntervalsResponse(
        routeTimeIntervals: Map.from(json["routeTimeIntervals"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "routeTimeIntervals": Map.from(routeTimeIntervals)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
