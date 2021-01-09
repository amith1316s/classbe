import 'package:classbe/account.dart';
import 'package:flutter/material.dart';
import 'package:classbe/components/default_button.dart';
import 'package:classbe/size_config.dart';
import 'package:classbe/domain/data.dart';
import 'package:classbe/screens/home/home_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Data _data = ModalRoute.of(context).settings.arguments;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/remitmama_icon.png",
                height: SizeConfig.screenHeight * 0.35,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.65,
                child: DefaultButton(
                  text: "Welcome Home",
                  press: () {
                    home(context, _data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void home(BuildContext context, Data data) {
    if (data.userProfile.account == Account.dealer) {
      if (!data.userProfile.businessProfile.profileComplete) {
        // Navigator.pushNamed(context, AddBusinessProfileScreen.routeName,
        //     arguments: data);
      } else {
        Navigator.pushNamed(context, HomeScreen.routeName, arguments: data);
      }
    } else {
      Navigator.pushNamed(context, HomeScreen.routeName, arguments: data);
    }
  }
}
