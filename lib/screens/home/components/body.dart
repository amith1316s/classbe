import 'package:flutter/material.dart';
import 'package:classbe/constants.dart';

class Body extends StatelessWidget {
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = kPrimaryLightColor;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.grey.shade300, child: Text('Welcome Home'));
  }
}
