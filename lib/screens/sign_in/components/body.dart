import 'package:classbe/screens/sign_up/components/sign_up_text.dart';
import 'package:classbe/size_config.dart';
import 'package:flutter/material.dart';
import 'sign_in_form.dart';
import 'background.dart';
import 'package:classbe/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10),
          // padding:
          //     EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /* Image.asset('assets/backgrounds/online-education.jpg',
                width: 100.0,
                height: 100.0,), */
                // SizedBox(height: SizeConfig.screenHeight * 0.03),
                SizedBox(height: 10.0),
                Text('Sign In', style: headingStyle),

                SizedBox(height: 15.0),
                Container(
                  height: 80.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: kMainPrimaryColor, width: 2.0)),
                  child: Container(
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: kMainPrimaryColor),
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

                /*  Text(
                  "Sign in with your email and password  \nor with social media",
                  textAlign: TextAlign.center,
                ), */
                SizedBox(height: 20.0),
                SignInForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                SignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
