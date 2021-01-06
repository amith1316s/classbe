import 'package:flutter/material.dart';
import 'package:classbe/constants.dart';
import 'package:classbe/size_config.dart';
import 'package:classbe/screens/terms_conditions/terms_conditions_screen.dart';

import 'body_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text(
                  "Complete Profile",
                  style: TextStyle(fontSize: 24, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "You're almost done, please complete your details ",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                BodyForm(),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "By continuing you agree with our ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, TermsAndConditionsScreen.routeName),
                  child: Text(
                    "Terms and Condition",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
