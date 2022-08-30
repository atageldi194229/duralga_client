import 'package:duralga_client/presentation/components/side_menu/draggable_scrollable_sheet_side_menu.dart';
import 'package:duralga_client/presentation/components/side_menu/side_menu.dart';
import 'package:duralga_client/presentation/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'custom_map.dart';

class Body extends HookWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      // crossAxisAlignment: CrossAxisAlignment.,
      children: [
        if (!Responsive.isMobile(context)) const SideMenu(),
        Expanded(
          child: ColoredBox(
            color: Colors.red.withOpacity(0.3),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                const CustomMap(),
                if (Responsive.isMobile(context))
                  const DraggableScrollableSheetSideMenu(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
