import 'dart:convert';

class RouteBusCollectionModel {
  RouteBusCollectionModel({
    required this.buses,
  });

  final List<Bus> buses;

  factory RouteBusCollectionModel.fromJson(String str) =>
      RouteBusCollectionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RouteBusCollectionModel.fromMap(Map<String, dynamic> json) =>
      RouteBusCollectionModel(
        buses: List<Bus>.from(json["buses"].map((x) => Bus.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "buses": List<dynamic>.from(buses.map((x) => x.toMap())),
      };
}

class Bus {
  Bus({
    required this.carNumber,
    required this.locations,
    required this.number,
    required this.isAb,
  });

  final String carNumber;
  final List<Location> locations;
  final int number;
  final bool? isAb;

  factory Bus.fromJson(String str) => Bus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bus.fromMap(Map<String, dynamic> json) => Bus(
        carNumber: json["car_number"],
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromMap(x))),
        number: json["number"],
        isAb: json["isAb"],
      );

  Map<String, dynamic> toMap() => {
        "car_number": carNumber,
        "locations": List<dynamic>.from(locations.map((x) => x.toMap())),
        "number": number,
        "isAb": isAb,
      };
}

class Location {
  Location({
    required this.point,
    required this.ab,
    required this.ba,
  });

  final List<double> point;
  final Ab ab;
  final Ab ba;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        point: List<double>.from(json["point"].map((x) => x.toDouble())),
        ab: Ab.fromMap(json["ab"]),
        ba: Ab.fromMap(json["ba"]),
      );

  Map<String, dynamic> toMap() => {
        "point": List<dynamic>.from(point.map((x) => x)),
        "ab": ab.toMap(),
        "ba": ba.toMap(),
      };
}

class Ab {
  Ab({
    required this.dist,
    required this.location,
    required this.index,
    required this.point,
    required this.bearing,
  });

  final double dist;
  final double location;
  final int index;
  final List<double> point;
  final double bearing;

  factory Ab.fromJson(String str) => Ab.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ab.fromMap(Map<String, dynamic> json) => Ab(
        dist: json["dist"].toDouble(),
        location: json["location"].toDouble(),
        index: json["index"],
        point: List<double>.from(json["point"].map((x) => x.toDouble())),
        bearing: json["bearing"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "dist": dist,
        "location": location,
        "index": index,
        "point": List<dynamic>.from(point.map((x) => x)),
        "bearing": bearing,
      };
}
