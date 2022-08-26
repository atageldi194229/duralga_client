import 'package:duralga_client/presentation/components/side_menu.dart';
import 'package:duralga_client/presentation/responsive.dart';
import 'package:flutter/material.dart';

import 'custom_map.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.green.withOpacity(0.3),
      child: Row(
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
      ),
    );
  }
}

class DraggableScrollableSheetSideMenu extends StatelessWidget {
  const DraggableScrollableSheetSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.amber.withOpacity(0.5),
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 1,
        minChildSize: 0.05,
        snapSizes: const [0.5],
        snap: true,
        expand: false,
        builder: (context, scrollController) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SideMenu(
              scrollController: scrollController,
            ),
          );
        },
      ),
    );
  }
}
