import 'package:classbe/account.dart';
import 'package:classbe/domain/user_profile.dart';
import 'package:classbe/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:classbe/components/default_button.dart';
import 'package:classbe/components/form_error.dart';
import 'package:classbe/components/social_icons.dart';
import 'package:classbe/constants.dart';
import 'package:classbe/size_config.dart';
import 'package:classbe/domain/data.dart';
import 'package:classbe/domain/firestore_collection.dart';

class BodyForm extends StatefulWidget {
  @override
  _BodyFormState createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobilePhoneNumberController =
      TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;

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
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                addUserProfile();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> addUserProfile() {
    _data.userProfile = UserProfile();
    User user = FirebaseAuth.instance.currentUser;
    _data.userProfile.uid = user.uid;
    _data.userProfile.email = user.email;
    _data.userProfile.firstName = _firstNameController.text;
    _data.userProfile.lastName = _lastNameController.text;
    _data.userProfile.mobilePhone.iso = _mobilePhoneIso;
    _data.userProfile.mobilePhone.code = _mobilePhoneCode;
    _data.userProfile.mobilePhone.number = _mobilePhoneNumberController.text;
    _data.userProfile.address.street = _streetController.text;
    _data.userProfile.address.city = _cityController.text;
    _data.userProfile.address.country = _countryController.text;
    _data.userProfile.memberSince = DateTime.now();
    _data.userProfile.account = Account.user;

    String collection = FirestoreCollection.users;
    String doc = _data.userProfile.uid;

    return FirebaseFirestore.instance
        .collection(collection)
        .doc(doc)
        .set(_data.userProfile.toFirestore())
        .then((value) => {
              Navigator.pushNamed(context, HomeScreen.routeName,
                  arguments: _data)
            })
        .catchError((error) => print("Failed to add user profile: $error"));
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
          child: Icon(Icons.phone, color: Colors.black),
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
          child: Icon(Icons.person, color: Colors.black),
        ),
      ),
      controller: _lastNameController,
    );
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
          child: Icon(Icons.person, color: Colors.black),
        ),
      ),
      controller: _firstNameController,
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
          child: Icon(Icons.location_on, color: Colors.black),
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
          child: Icon(Icons.location_city, color: Colors.black),
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
          child: Icon(SocialIcons.globeAfrica, color: Colors.black),
        ),
      ),
      controller: _countryController,
    );
  }
}
