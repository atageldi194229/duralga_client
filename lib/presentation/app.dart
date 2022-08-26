import 'package:duralga_client/presentation/components/side_menu.dart';
import 'package:duralga_client/presentation/responsive.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Duralga Client",
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Builder(builder: (context) {
            return Row(
              children: [
                if (!Responsive.isMobile(context)) const SideMenu(),
                Expanded(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Congratulations!",
                          ),
                        ],
                      ),
                      if (Responsive.isMobile(context))
                        DraggableScrollableSheet(
                          builder: (context, scrollController) {
                            return const SideMenu();
                          },
                        )
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
