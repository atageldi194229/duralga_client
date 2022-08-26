import 'package:duralga_client/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SideMenu extends HookWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = <TabModel>[
      TabModel(name: "Routes", child: Container()),
      TabModel(name: "Stops", child: Container()),
      TabModel(name: "Places", child: Container()),
      TabModel(name: "Maps", child: Container()),
      TabModel(name: "Info", child: Container()),
    ];

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SearchField(),
            const SizedBox(height: defaultPadding),
            _TabBars(
              tabs: tabs,
            ),
            const SizedBox(height: defaultPadding),
            
          ],
        ),
      ),
    );
  }
}

@immutable
class TabModel {
  final String name;
  final Widget child;

  const TabModel({
    required this.name,
    required this.child,
  });
}

class _TabBars extends HookWidget {
  const _TabBars({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<TabModel> tabs;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabs
              .map<Widget>(
                (e) => Container(
                  margin: const EdgeInsets.only(
                    right: defaultPadding,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color:
                              Theme.of(context).textTheme.bodyMedium!.color ??
                                  Colors.grey,
                        ),
                      ),
                    ),
                    child: InkWell(
                      borderRadius: borderRadius,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Text(
                          e.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search routes",
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius,
        ),
        prefixIcon: _buildIconButton(
          onTap: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconButton(
              onTap: () {},
              icon: const Icon(Icons.search),
            ),
            Container(
              height: 20,
              width: 1,
              color: Colors.grey,
            ),
            _buildIconButton(
              onTap: () {},
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required Widget icon,
    VoidCallback? onTap,
  }) {
    const padding = EdgeInsets.all(defaultPadding * 0.75);

    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      decoration: const BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: icon,
        ),
      ),
    );
  }
}
