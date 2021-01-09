import 'package:classbe/constants.dart';
import 'package:classbe/screens/terms_conditions/terms_conditions_screen.dart';
import 'package:classbe/size_config.dart';
import 'package:flutter/material.dart';
import 'sign_up_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.03), // 4%
                Text("Sign up", style: headingStyle),
                SizedBox(height: 10.0),
                Container(
                  height: 80.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: kMainPrimaryColor, width: 2.0)),
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: kMainPrimaryColor,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/logo_hat.png',
                          width: 100,
                          height: 100,
                        ),
                        Image.asset(
                          'assets/logo_name.png',
                          width: 100,
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text(
                  'By continuing you agree with our ',
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
                        fontWeight: FontWeight.bold,
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
