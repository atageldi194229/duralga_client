import 'package:duralga_client/presentation/widgets/cached_tile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final tileLayerOptions = TileLayerOptions(
  tileProvider: CachedTileProvider(),
  urlTemplate: "https://geo.asmantiz.com/tile/{z}/{x}/{y}.png",

  // urlTemplate: "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  // subdomains: ['a', 'b', 'c'],
);

const borderRadius = BorderRadius.all(Radius.circular(10));
const primaryColor = Color(0xFF2272fb);
const secondaryColor = Color(0xFF01a469);
const kGreenColor = Color(0xFF01a469);
// const bgColor = Color(0xFFFFFFFF);
// const bgColor = Color(0xFF212332);

const defaultPadding = 8.0;
