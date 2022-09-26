import 'dart:convert';

class StopArrivalTimeResponse {
  StopArrivalTimeResponse({
    required this.stopId,
    required this.arrivalTime,
  });

  int stopId;
  Map<String, List<ArrivalTime>> arrivalTime;

  factory StopArrivalTimeResponse.fromJson(String str) =>
      StopArrivalTimeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StopArrivalTimeResponse.fromMap(Map<String, dynamic> json) =>
      StopArrivalTimeResponse(
        stopId: json["stopId"],
        arrivalTime: Map.from(json["arrivalTime"]).map((k, v) =>
            MapEntry<String, List<ArrivalTime>>(k,
                List<ArrivalTime>.from(v.map((x) => ArrivalTime.fromMap(x))))),
      );

  Map<String, dynamic> toMap() => {
        "stopId": stopId,
        "arrivalTime": Map.from(arrivalTime).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toMap())))),
      };
}

class ArrivalTime {
  ArrivalTime({
    required this.n,
    required this.t,
    required this.cn,
    required this.l,
    required this.deg,
    required this.direction,
  });

  int n;
  double t;
  String cn;
  List<String> l;
  int deg;
  bool direction;

  factory ArrivalTime.fromJson(String str) =>
      ArrivalTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArrivalTime.fromMap(Map<String, dynamic> json) => ArrivalTime(
        n: json["n"],
        t: json["t"].toDouble(),
        cn: json["cn"],
        l: List<String>.from(json["l"].map((x) => x)),
        deg: json["deg"],
        direction: json["direction"],
      );

  Map<String, dynamic> toMap() => {
        "n": n,
        "t": t,
        "cn": cn,
        "l": List<dynamic>.from(l.map((x) => x)),
        "deg": deg,
        "direction": direction,
      };
}
