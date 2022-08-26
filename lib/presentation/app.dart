import 'package:duralga_client/presentation/components/side_menu.dart';
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
          child: Row(
            children: const [
              Expanded(
                child: SideMenu(),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text("Congratulations!"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
