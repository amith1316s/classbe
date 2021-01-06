import 'package:flutter/material.dart';

import 'components/body.dart';

class ViewProfileScreen extends StatelessWidget {
  static String routeName = "/my_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Body(),
    );
  }
}
