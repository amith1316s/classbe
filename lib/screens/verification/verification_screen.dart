import 'package:classbe/size_config.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class VerificationScreen extends StatelessWidget {
  static String routeName = "/verification";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
      ),
      body: Body(),
    );
  }
}
