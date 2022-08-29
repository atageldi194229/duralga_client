import 'dart:convert';

class RouteModel {
  RouteModel({
    required this.id,
    required this.routeId,
    required this.number,
    required this.description,
    required this.startCoords,
    required this.endCoords,
    required this.startStops,
    required this.endStops,
  });

  final int id;
  final int routeId;
  final int number;
  final List<String> description;
  final List<List<String>> startCoords;
  final List<List<String>> endCoords;
  final List<int> startStops;
  final List<int> endStops;

  factory RouteModel.fromJson(String str) =>
      RouteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RouteModel.fromMap(Map<String, dynamic> json) => RouteModel(
        id: json["id"],
        routeId: json["routeId"],
        number: json["number"],
        description: List<String>.from(json["description"].map((x) => x)),
        startCoords: List<List<String>>.from(json["start_coords"]
            .map((x) => List<String>.from(x.map((x) => x)))),
        endCoords: List<List<String>>.from(
            json["end_coords"].map((x) => List<String>.from(x.map((x) => x)))),
        startStops: List<int>.from(json["start_stops"].map((x) => x)),
        endStops: List<int>.from(json["end_stops"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "routeId": routeId,
        "number": number,
        "description": List<dynamic>.from(description.map((x) => x)),
        "start_coords": List<dynamic>.from(
            startCoords.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "end_coords": List<dynamic>.from(
            endCoords.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "start_stops": List<dynamic>.from(startStops.map((x) => x)),
        "end_stops": List<dynamic>.from(endStops.map((x) => x)),
      };
}
