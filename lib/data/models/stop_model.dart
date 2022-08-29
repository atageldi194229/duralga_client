import 'dart:convert';

class StopModel {
  StopModel({
    required this.id,
    required this.stopId,
    required this.name,
    required this.location,
    required this.endpoint,
  });

  final int id;
  final int stopId;
  final String name;
  final List<String> location;
  final bool endpoint;

  factory StopModel.fromJson(String str) => StopModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StopModel.fromMap(Map<String, dynamic> json) => StopModel(
        id: json["id"],
        stopId: json["stopId"],
        name: json["name"],
        location: List<String>.from(json["location"].map((x) => x)),
        endpoint: json["endpoint"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "stopId": stopId,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
        "endpoint": endpoint,
      };
}
