import 'package:duralga_client/bloc/app_bloc/app_bloc.dart';
import 'package:duralga_client/presentation/components/side_menu/route_list.dart';
import 'package:duralga_client/presentation/components/side_menu/route_view/route_view.dart';
import 'package:duralga_client/presentation/components/side_menu/search_field.dart';
import 'package:duralga_client/presentation/components/side_menu/stop_list.dart';
import 'package:duralga_client/presentation/components/side_menu/stop_view/stop_view.dart';
import 'package:duralga_client/presentation/constants.dart';
import 'package:duralga_client/presentation/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final appBloc = context.read<AppBloc>();

    final tabs = <TabModel>[
      TabModel(
          name: "Routes",
          onTap: () {
            appBloc.add(AppEventGoToRouteList());
          }),
      TabModel(
          name: "Stops",
          onTap: () {
            appBloc.add(AppEventGoToStopList());
          }),
      TabModel(name: "Places", onTap: () {}),
      TabModel(name: "Maps", onTap: () {}),
      TabModel(name: "Info", onTap: () {}),
    ];

    return Drawer(
      width: Responsive.isDesktop(context) ? 350 : null,
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
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding)
                                .copyWith(bottom: 0),
                            child: Column(
                              children: [
                                const SearchField(),
                                const SizedBox(height: defaultPadding),
                                _TabBars(
                                  tabs: tabs,
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(height: defaultPadding),
                          const Divider(
                            thickness: defaultPadding / 2,
                          ),
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
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    if (state is AppStateRouteSelected) {
                      return RouteView(state.route);
                    }

                    if (state is AppStateStopSelected) {
                      return StopView(state.stop);
                    }

                    if (state is AppStateStopList) {
                      return const StopList();
                    }

                    if (state is AppStateRouteList) {
                      return const RouteList();
                    }

                    return const RouteList();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class TabModel {
  final String name;
  final VoidCallback? onTap;

  const TabModel({
    required this.name,
    this.onTap,
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
                  bottom: defaultPadding,
                ),
                decoration: (index == selected.value)
                    ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: kGreenColor,
                          ),
                        ),
                      )
                    : null,
                child: InkWell(
                  borderRadius: borderRadius,
                  onTap: () {
                    selected.value = index;
                    tabs[index].onTap?.call();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(
                      tabs[index].name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color:
                                (index == selected.value) ? kGreenColor : null,
                          ),
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
