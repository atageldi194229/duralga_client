class CustomRouter {
  final List<CustomRouter> list;
  final Type type;

  CustomRouter(
    this.type, [
    this.list = const [],
  ]);

  bool isSubClassOf(
    Type b,
    Type a, [
    bool foundA = false,
  ]) {
    if (b == type) {
      return foundA;
    }

    if (a == type) {
      foundA = true;
    }

    for (var el in list) {
      if (el.isSubClassOf(b, a, foundA)) {
        return true;
      }
    }

    return false;
  }
}

class BlocNavigator<T> {
  final CustomRouter customRouter;
  BlocNavigator(this.customRouter);

  List<T> list = [];

  T push(T state) {
    while (list.isNotEmpty) {
      final last = list.removeLast();

      if (last.runtimeType == state.runtimeType) {
        list.add(state);
        return state;
      }

      if (customRouter.isSubClassOf(state.runtimeType, last.runtimeType)) {
        list.addAll([last, state]);
        return state;
      }
    }

    list.add(state);
    return state;
  }

  T pop() {
    if (list.length > 1) list.removeLast();
    return list.last;
  }

  T last() {
    return list.last;
  }
}
