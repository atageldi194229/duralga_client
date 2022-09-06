import 'package:flutter/foundation.dart' show immutable;

typedef CallbackFunction = Function?;

@immutable
abstract class AppError {
  final String title;
  final String description;
  final CallbackFunction callback;

  const AppError({
    required this.title,
    required this.description,
    this.callback,
  });

  @override
  bool operator ==(covariant AppError other) {
    if (identical(this, other)) return true;

    return other.title == title && other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}

@immutable
class LoadError extends AppError {
  const LoadError({
    CallbackFunction callback,
  }) : super(
          title: "Load error",
          description: "Maybe internet connection error",
          callback: callback,
        );
}
