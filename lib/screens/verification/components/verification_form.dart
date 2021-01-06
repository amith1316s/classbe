import 'package:classbe/common_event.dart';
import 'package:classbe/components/default_button.dart';
import 'package:classbe/constants.dart';
import 'package:classbe/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({
    Key key,
  }) : super(key: key);

  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.10),
          DefaultButton(
            text: "Confirm",
            press: () {
              _confirmVerification();
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          GestureDetector(
            onTap: () async {
              _emailVerification();
            },
            child: Text(
              "Resend Verification",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor),
            ),
          )
        ],
      ),
    );
  }

  void _emailVerification() async {
    await FirebaseAuth.instance.currentUser.reload();
    User user = FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
  }

  void _confirmVerification() async {
    await FirebaseAuth.instance.currentUser.reload();
    User user = FirebaseAuth.instance.currentUser;
    if (user.emailVerified) {
      CommonEvent.isUserProfileInFirestore(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email not yet verified. Please verify email'),
      ));
    }
  }
}
