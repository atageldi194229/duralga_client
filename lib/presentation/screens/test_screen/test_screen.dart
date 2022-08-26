import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableScrollableSheet(
        minChildSize: 0.1,
        initialChildSize: 0.15,
        maxChildSize: 0.8,
        builder: (context, scrollController) => Material(
          elevation: 8,
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) => ListTile(
              title: Text("Item $index"),
            ),
          ),
        ),
      ),
    );
  }
}
