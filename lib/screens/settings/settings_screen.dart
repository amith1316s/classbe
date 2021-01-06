import 'package:flutter/material.dart';
import 'package:classbe/screens/settings/components/body.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Body(),
    );
  }
}
