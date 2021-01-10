import 'package:classbe/common_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:classbe/components/oval-right-clipper.dart';
import 'package:classbe/constants.dart';
import 'package:classbe/domain/data.dart';
import 'package:classbe/screens/profile/view_profile/view_profile_screen.dart';
import 'package:classbe/screens/settings/settings_screen.dart';
import 'package:classbe/screens/sign_in/sign_in_screen.dart';
import 'package:classbe/extentions.dart';

/// This is the stateful widget that the main application instantiates.
class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _BodyStatefulWidget createState() => _BodyStatefulWidget();
}

class _BodyStatefulWidget extends State<Menu> {
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = kPrimaryLightColor;

  Data _data;

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 40),
      decoration: BoxDecoration(
          color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
      width: 280,
      height: double.infinity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: active,
                  ),
                  onPressed: () {
                    _signOut(context);
                  },
                ),
              ),
              Container(
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [kPrimaryLightColor, kPrimaryColor])),
                child: GestureDetector(
                  child: _data.userProfile.imageUrl == null
                      ? CircleAvatar(
                          radius: 45,
                          child: Icon(Icons.add_a_photo),
                        )
                      : CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              NetworkImage(_data.userProfile.imageUrl),
                        ),
                  onTap: () async {
                    PickedFile image = await ImagePicker().getImage(
                      source: ImageSource.gallery,
                    );
                    print(image.path);

                    await CommonEvent.uploadFile(image, _data);
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                _data.userProfile.firstName.capitalize() +
                    ' ' +
                    _data.userProfile.lastName.capitalize(),
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: _buildRow(Icons.home, "Home"),
              ),
              _buildDivider(),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, ViewProfileScreen.routeName,
                      arguments: _data);
                },
                child: _buildRow(Icons.person_pin_rounded, "My Profile"),
              ),
              _buildDivider(),
              GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, ViewProfileScreen.routeName);
                },
                child: _buildRow(Icons.message, "Messages", showBadge: true),
              ),
              _buildDivider(),
              GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, ViewProfileScreen.routeName);
                },
                child: _buildRow(Icons.notifications, "Notifications",
                    showBadge: true),
              ),
              _buildDivider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                },
                child: _buildRow(Icons.settings, "Settings"),
              ),
              _buildDivider(),
              GestureDetector(
                onTap: () {
                  _signOut(context);
                },
                child: _buildRow(Icons.exit_to_app, "Sign Out"),
              ),
              _buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: kPrimaryColor,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, SignInScreen.routeName, (Route<dynamic> route) => false);
  }
}
