import 'package:duralga_client/data/models/stop_model.dart';
import 'package:latlong2/latlong.dart';

extension ConvertStopModelLocationToLatLng on StopModel {
  LatLng get latLng => LatLng(
        double.parse(location[0]),
        double.parse(location[1]),
      );
}
