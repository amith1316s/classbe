import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:classbe/components/social_icons.dart';
import 'package:classbe/constants.dart';
import "package:classbe/extentions.dart";
import 'package:classbe/size_config.dart';
import 'package:classbe/domain/data.dart';
import 'package:classbe/common_event.dart';
import 'package:classbe/screens/profile/edit_profile/edit_profile_screen.dart';

class Body extends StatefulWidget {
  @override
  Body({Key key}) : super(key: key);

  @override
  _BodyStatefulWidget createState() => _BodyStatefulWidget();
}

class _BodyStatefulWidget extends State<Body> {
  final imagebackground = 'assets/images/landscape.png';
  final image = 'assets/images/profile.jpg';
  final camera = 'assets/icons/camera.png';
  Data _data;

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: _floatingButton(context),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
                height: 250,
                width: double.maxFinite,
                child: Image.asset(imagebackground, fit: BoxFit.cover)),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 95.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.only(top: 25.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      (_data.userProfile.firstName != null &&
                                              _data.userProfile.lastName !=
                                                  null)
                                          ? _data.userProfile.firstName
                                                  .capitalize() +
                                              ' ' +
                                              _data.userProfile.lastName
                                                  .capitalize()
                                          : '',
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(22),
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                        _data.userProfile.account != null
                                            ? _data.userProfile.account
                                            : '',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    subtitle: Text(
                                        _data.userProfile.memberSince != null
                                            ? "Joined: " +
                                                _data.userProfile.memberSince
                                                    .ddMMMyyyy()
                                            : '',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(14),
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        color: kPrimaryColor,
                                        icon: Icon(SocialIcons.instagram,
                                            size: 20),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        color: kPrimaryColor,
                                        icon: Icon(
                                          SocialIcons.facebookF,
                                          size: 18,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      IconButton(
                                        color: kPrimaryColor,
                                        icon:
                                            Icon(SocialIcons.twitter, size: 20),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          PickedFile image = await ImagePicker().getImage(
                            source: ImageSource.gallery,
                          );
                          print(image.path);

                          await CommonEvent.uploadFile(image, _data);
                          setState(() {});
                        },
                        child: _data.userProfile.imageUrl == null
                            ? _profileImageBlank()
                            : _profileImage(),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Divider(
                          color: kPrimaryColor,
                          height: 0,
                          thickness: 1,
                        ),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text(_data.userProfile.email != null
                              ? _data.userProfile.email
                              : ''),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text(_data.userProfile.mobilePhone
                                      .getFullMobilePhoneNumber() !=
                                  null
                              ? _data.userProfile.mobilePhone
                                  .getFullMobilePhoneNumber()
                              : ''),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Address"),
                          subtitle: Text(_data.userProfile.getFullAddress()),
                          leading: Icon(Icons.location_on),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, EditProfileScreen.routeName,
            arguments: _data);
      },
      backgroundColor: kPrimaryColor,
      child: Icon(Icons.edit,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  Container _profileImage() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
            image: Image.network(_data.userProfile.imageUrl).image,
            fit: BoxFit.cover),
      ),
      margin: EdgeInsets.only(left: 16.0),
    );
  }

  Container _profileImageBlank() {
    return Container(
      height: 80,
      width: 80,
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.add_a_photo,
          size: 40,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      margin: EdgeInsets.only(left: 16.0),
    );
  }
}
