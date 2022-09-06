import 'package:duralga_client/data/errors/app_error.dart';
import 'package:flutter/material.dart' show BuildContext;

import 'generic_dialog.dart';

Future<void> showAppErrorWithTryAgain({
  required AppError error,
  required BuildContext context,
}) {
  return showGenericDialog<bool>(
    context: context,
    title: error.title,
    content: error.description,
    optionsBuilder: () => {
      'Try again': true,
    },
  );
}
