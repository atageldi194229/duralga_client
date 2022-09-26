import 'package:duralga_client/bloc/map_bloc/map_bloc.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:duralga_client/presentation/screens/home_screen/info_panel.dart';
import 'package:duralga_client/presentation/widgets/my_location_waiting_animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'custom_map/custom_map_body.dart';

class Body extends HookWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const CustomMapBody(),
        const InfoPanel(),
        Positioned(
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: FloatingActionButton(
              onPressed: () {
                context
                    .read<MapBloc>()
                    .add(MapEventToggleLiveCurrentLocation());
              },
              child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (!state.live && state.currentLocation == null) {
                    return const Icon(Icons.location_searching_rounded);
                  }

                  if (state.live && state.currentLocation == null) {
                    return const MyLocationWaitingAnimatedIcon();
                  }

                  return const Icon(Icons.my_location_rounded);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
