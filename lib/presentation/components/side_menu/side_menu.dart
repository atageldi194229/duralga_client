import 'package:duralga_client/presentation/components/side_menu/route_list.dart';
import 'package:duralga_client/presentation/components/side_menu/search_field.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:duralga_client/presentation/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SideMenu extends HookWidget {
  const SideMenu({
    Key? key,
    this.scrollController,
    this.top,
  }) : super(key: key);

  final Widget? top;
  final ScrollController? scrollController;

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
      width: Responsive.isDesktop(context) ? 350 : null,
      child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (top != null) top!,
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SearchField(),
                              const SizedBox(height: defaultPadding),
                              _TabBars(
                                tabs: tabs,
                              ),
                              const SizedBox(height: defaultPadding),
                            ],
                          );
                        },
                        childCount: 1,
                      ),
                    ),

                    // const SliverAppBar(
                    //   pinned: true,
                    //   flexibleSpace: FlexibleSpaceBar(
                    //     title: Text(''),
                    //   ),
                    // ),
                    const RouteList(),
                  ],
                ),
              ),
            ],
          )
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     // controller: scrollController,
          //     // shrinkWrap: true,
          //     children: [
          //       const SearchField(),
          //       const SizedBox(height: defaultPadding),
          //       _TabBars(
          //         tabs: tabs,
          //       ),
          //       const SizedBox(height: defaultPadding),
          //       Expanded(
          //         child: BlocBuilder<AppBloc, AppState>(
          //           buildWhen: (p, c) => p.routes.length != c.routes.length,
          //           builder: (context, state) {
          //             return RouteList(
          //               state.routes.toList(),
          //               // scrollController: scrollController,
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
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
    final selected = useState<int>(0);

    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            tabs.length,
            (index) => Container(
              margin: const EdgeInsets.only(
                right: defaultPadding,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(
                  bottom: defaultPadding * 2,
                ),
                decoration: BoxDecoration(
                  border: (index == selected.value)
                      ? Border(
                          bottom: BorderSide(
                            width: 2,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color ??
                                    Colors.grey,
                          ),
                        )
                      : null,
                ),
                child: InkWell(
                  borderRadius: borderRadius,
                  onTap: () {
                    selected.value = index;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(
                      tabs[index].name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
