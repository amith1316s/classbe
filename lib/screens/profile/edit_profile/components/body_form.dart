import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:classbe/components/default_button.dart';
import 'package:classbe/components/form_error.dart';
import 'package:classbe/components/social_icons.dart';
import 'package:classbe/constants.dart';
import 'package:classbe/size_config.dart';
import 'package:classbe/domain/data.dart';
import 'package:classbe/domain/firestore_collection.dart';
import 'package:classbe/screens/profile/view_profile/view_profile_screen.dart';

class BodyForm extends StatefulWidget {
  @override
  _BodyFormState createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobilePhoneNumberController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();

  Data _data;

  String _mobilePhoneIso = 'GB';
  String _mobilePhoneCode;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobilePhoneNumberController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;

    _firstNameController.text = _data.userProfile.firstName;
    _lastNameController.text = _data.userProfile.lastName;

    _mobilePhoneIso = _data.userProfile.mobilePhone.iso;
    _mobilePhoneCode = _data.userProfile.mobilePhone.code;
    _mobilePhoneNumberController.text = _data.userProfile.mobilePhone.number;

    _streetController.text = _data.userProfile.address.street;
    _cityController.text = _data.userProfile.address.city;
    _countryController.text = _data.userProfile.address.country;

    _twitterController.text = _data.userProfile.twitter;
    _instagramController.text = _data.userProfile.instagram;
    _facebookController.text = _data.userProfile.facebook;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildMobileNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildStreetFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCountryFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildTwitterFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildInstagramFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildFacebookFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Save",
            press: () {
              if (_formKey.currentState.validate()) {
                updateUserProfile();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> updateUserProfile() {
    _data.userProfile.firstName = _firstNameController.text;
    _data.userProfile.lastName = _lastNameController.text;
    _data.userProfile.mobilePhone.iso = _mobilePhoneIso;
    _data.userProfile.mobilePhone.code = _mobilePhoneCode;
    _data.userProfile.mobilePhone.number = _mobilePhoneNumberController.text;

    _data.userProfile.address.street = _streetController.text;
    _data.userProfile.address.city = _cityController.text;
    _data.userProfile.address.country = _countryController.text;
    _data.userProfile.twitter = _twitterController.text;
    _data.userProfile.facebook = _facebookController.text;
    _data.userProfile.instagram = _instagramController.text;

    String collection = FirestoreCollection.users;
    String doc = _data.userProfile.uid;

    return FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .update(_data.userProfile.toFirestore())
        .then((value) => {
              Navigator.pop(context, ViewProfileScreen.routeName),
              Navigator.popAndPushNamed(context, ViewProfileScreen.routeName,
                  arguments: _data)
            })
        .catchError((error) => print("Failed to update user profile: $error"));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kFirstNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.person, color: kMainPrimaryColor),
        ),
      ),
      controller: _firstNameController,
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kLastNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.person, color: kMainPrimaryColor),
        ),
      ),
      controller: _lastNameController,
    );
  }

  Widget buildMobileNumberFormField() {
    return IntlPhoneField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Mobile Number",
        hintText: "Enter mobile number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.phone, color: kMainPrimaryColor),
        ),
      ),
      initialCountryCode: _mobilePhoneIso,
      onChanged: (value) {
        if (value.completeNumber.isNotEmpty) {
          removeError(error: kMobileNumberNullError);
        }
        _mobilePhoneCode = value.countryCode;
        _mobilePhoneIso = value.countryISOCode;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kMobileNumberNullError);
          return "";
        }
        return null;
      },
      controller: _mobilePhoneNumberController,
    );
  }

  TextFormField buildStreetFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Street",
        hintText: "Enter street",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.location_on, color: kMainPrimaryColor),
        ),
      ),
      controller: _streetController,
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter city",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.location_city, color: kMainPrimaryColor),
        ),
      ),
      controller: _cityController,
    );
  }

  TextFormField buildCountryFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Country",
        hintText: "Enter country",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(SocialIcons.globeAfrica, color: kMainPrimaryColor),
        ),
      ),
      controller: _countryController,
    );
  }

  TextFormField buildTwitterFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Twitter",
        hintText: "Enter twitter id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(SocialIcons.twitter, color: kMainPrimaryColor),
        ),
      ),
      controller: _twitterController,
    );
  }

  TextFormField buildInstagramFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Instagram",
        hintText: "Enter instagram id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(SocialIcons.instagramSquare, color: kMainPrimaryColor),
        ),
      ),
      controller: _instagramController,
    );
  }

  TextFormField buildFacebookFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Facebook",
        hintText: "Enter facebook id",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(SocialIcons.facebookSquare, color: kMainPrimaryColor),
        ),
      ),
      controller: _facebookController,
    );
  }
}
