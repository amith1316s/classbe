import 'package:flutter/material.dart';

import 'package:classbe/constants.dart';
import 'package:classbe/size_config.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to ***"),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: kPrimaryColor),
                ),
              )
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
