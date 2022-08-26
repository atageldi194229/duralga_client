import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.amber.withOpacity(0.3),
      child: FlutterMap(
        // mapController: myMapController.myMapController,
        options: MapOptions(
          // plugins: [MarkerClusterPlugin()],
          center: LatLng(37.862499, 58.238056),
          zoom: 15.0,
          maxZoom: 18.0,
          minZoom: 8.0,
        ),
        layers: [
          TileLayerOptions(
            tileProvider: CachedTileProvider(),
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}

class CachedTileProvider extends TileProvider {
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      errorListener: () => const Icon(Icons.error),
      getTileUrl(coords, options),
    );
  }
}
