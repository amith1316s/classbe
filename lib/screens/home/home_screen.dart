import 'package:classbe/screens/home/components/menu.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Home"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.home_rounded,
                  size: 30.0,
                ),
              )),
        ],
      ),
      drawer: Menu(),
      body: Body(),
    );
  }
}
