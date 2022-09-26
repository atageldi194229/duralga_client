import 'package:duralga_client/extensions/convert_to_lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';

LayerOptions buildCurrentLocationLayer(LocationData location) {
  final point = location.latLng;

  // location.

  // final current = Marker(
  //   point: point,
  //   builder: (context) {
  //     return Container(
  //       decoration: const BoxDecoration(
  //         shape: BoxShape.circle,
  //       ),
  //       child: const FlutterLogo(
  //         size: 20,
  //         textColor: Colors.blue,
  //         key: ObjectKey(Colors.blue),
  //       ),
  //     );
  //   },
  // );

  return CircleLayerOptions(
    circles: [
      CircleMarker(
        //radius marker
        point: point,
        color: Colors.blue.withOpacity(0.7),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: 400, // 2000 meters | 2 km
      ),
    ],
  );
}
