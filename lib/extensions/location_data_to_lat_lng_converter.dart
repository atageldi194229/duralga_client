import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

extension LocationDataToLatLngConverter on LocationData {
  LatLng get latLng => LatLng(
        latitude!,
        longitude!,
      );
}
