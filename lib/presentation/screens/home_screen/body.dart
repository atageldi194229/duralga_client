import 'package:duralga_client/presentation/screens/home_screen/info_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'custom_map.dart';

class Body extends HookWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: const [
        CustomMap(),
        InfoPanel(),
      ],
    );
  }
}
