import 'package:classbe/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:classbe/screens/sign_in/sign_in_screen.dart';

/// This is the stateful widget that the main application instantiates.
class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyStatefulWidget createState() => _BodyStatefulWidget();
}

class _BodyStatefulWidget extends State<Body> {
  bool _receiveNotifications = false;
  bool _receiveNewsletter = false;
  bool _receiveOfferNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5.0),
            Text(
              "Push Notifications",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    activeColor: kPrimaryColor,
                    value: _receiveNotifications,
                    title: Text("Receive Notifications"),
                    onChanged: (bool value) {
                      setState(() {
                        _receiveNotifications = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: kPrimaryColor,
                    value: _receiveNewsletter,
                    title: Text("Receive Newsletter"),
                    onChanged: (bool value) {
                      setState(() {
                        _receiveNewsletter = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: kPrimaryColor,
                    value: _receiveOfferNotifications,
                    title: Text("Receive Offer Notifications"),
                    onChanged: (bool value) {
                      setState(() {
                        _receiveOfferNotifications = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Sign Out"),
                onTap: () {
                  _signOut(context);
                },
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade200,
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.routeName, (Route<dynamic> route) => false);
  }
}
