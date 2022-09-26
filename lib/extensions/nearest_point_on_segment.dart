import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

double distanceBetweenTwoPoints(LatLng a, LatLng b) {
  return math.sqrt(math.pow(a.latitude - b.latitude, 2) +
      math.pow(a.longitude - b.longitude, 2));
}

extension NearestPointOnSegment on LatLng {
  LatLng nearestPointOnSegment(LatLng a, LatLng b) {
    LatLng c = this;

    double cf = ((b.latitude - a.latitude) * (c.latitude - a.latitude) +
            (b.longitude - a.longitude) * (c.longitude - a.longitude)) /
        (math.pow(b.latitude - a.latitude, 2) +
            math.pow(b.longitude - a.longitude, 2));

    final d = LatLng(
      a.latitude + (b.latitude - a.latitude) * cf,
      a.longitude + (b.longitude - a.longitude) * cf,
    );

    if (cf > 1 || cf < 0) {
      double dac = distanceBetweenTwoPoints(a, c);
      double dbc = distanceBetweenTwoPoints(b, c);

      return dac < dbc ? a : b;
    }

    return d;
  }

  LatLng closestPointInSegment(LatLng p1, LatLng p2) {
    LatLng p = this;

    double x = p.longitude;
    double y = p.latitude;

    double x1 = p1.longitude;
    double y1 = p1.latitude;

    double x2 = p2.longitude;
    double y2 = p2.latitude;

    double a = x - x1;
    double b = y - y1;
    double c = x2 - x1;
    double d = y2 - y1;

    double lenSq = c * c + d * d;
    double param = -1.0;

    //in case of 0 length line
    if (lenSq != 0.0) {
      double dot = a * c + b * d;
      param = dot / lenSq;
    }

    double xx, yy;

    if (param < 0) {
      xx = x1;
      yy = y1;
    } else if (param > 1) {
      xx = x2;
      yy = y2;
    } else {
      xx = x1 + param * c;
      yy = y1 + param * d;
    }

    return LatLng(xx, yy);

    // double dx = x - xx;
    // double dy = y - yy;

    // double distance = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2));

    // return LatLng(dx, dy);
  }

  double distanceBetweenPointAndSegment(LatLng p1, LatLng p2) {
    LatLng p = this;

    double x = p.longitude;
    double y = p.latitude;

    double x1 = p1.longitude;
    double y1 = p1.latitude;

    double x2 = p2.longitude;
    double y2 = p2.latitude;

    double a = x - x1;
    double b = y - y1;
    double c = x2 - x1;
    double d = y2 - y1;

    double lenSq = c * c + d * d;
    double param = -1.0;

    //in case of 0 length line
    if (lenSq != 0.0) {
      double dot = a * c + b * d;
      param = dot / lenSq;
    }

    double xx, yy;

    if (param < 0) {
      xx = x1;
      yy = y1;
    } else if (param > 1) {
      xx = x2;
      yy = y2;
    } else {
      xx = x1 + param * c;
      yy = y1 + param * d;
    }

    // return LatLng(xx, yy);

    double dx = x - xx;
    double dy = y - yy;

    double distance = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2));

    return distance;

    // return LatLng(dx, dy);
  }
}
