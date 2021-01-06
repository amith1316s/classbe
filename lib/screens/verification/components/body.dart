import 'package:classbe/constants.dart';
import 'package:classbe/size_config.dart';
import 'package:flutter/material.dart';
import 'verification_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "Email Verification",
                style: headingStyle,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Text("We emailed your verification link to " + email,
                  textAlign: TextAlign.center),
              VerificationForm(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.00, end: 0.00),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value.toInt().toString().padLeft(2, "0")}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
