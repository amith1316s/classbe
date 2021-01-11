import 'package:classbe/constants.dart';
import 'package:classbe/screens/home/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:classbe/components/coustom_bottom_nav_bar.dart';
import 'package:classbe/enums.dart';

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
                  color: kMainPrimaryColor,
                  size: 30.0,
                ),
              )),
          SizedBox(
            width: 30.0,
          ),
        ],
      ),
      drawer: Menu(),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
