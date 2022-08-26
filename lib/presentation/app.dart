import 'package:duralga_client/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Duralga Client",
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      // home: const TestScreen(),
    );
  }
}
