import 'package:duralga_client/presentation/components/side_menu/centered_stick.dart';
import 'package:duralga_client/presentation/components/side_menu/side_menu.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class DraggableScrollableSheetSideMenu extends StatelessWidget {
  const DraggableScrollableSheetSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
            top: Column(
              children: const [
                CenteredStick(),
                SizedBox(height: defaultPadding),
              ],
            ),
          ),
        );
      },
    );
  }
}
