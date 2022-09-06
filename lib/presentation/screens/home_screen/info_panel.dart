import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding * 2,
          horizontal: defaultPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Маршруты города Ашхабад",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
