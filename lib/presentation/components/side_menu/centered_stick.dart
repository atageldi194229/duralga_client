import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class CenteredStick extends StatelessWidget {
  const CenteredStick({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
    );
  }
}
