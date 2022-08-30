import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class CenteredStick extends StatelessWidget {
  const CenteredStick({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
    );
  }
}
