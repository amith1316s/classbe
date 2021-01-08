import 'package:classbe/size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Colors.deepPurple;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kLogoPrimaryColor = Color(0xFFFF7643);
const kLogoSecondayColor = Color(0xFF43CCFF);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: Colors.deepPurple[900],
  height: 1.0,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";

const String kFirstNameNullError = "Please enter first name";
const String kLastNameNullError = "Please enter last name";
const String kMobileNumberNullError = "Please enter mobile number";

const String kBusinessNameNullError = "Please enter business name";

const String kOtpNullError = "Please enter your OTP code";
const String kOtpInvalidLengthError = "OTP code must be 6";

const String kAmountNullError = "Please enter amount";

const String kIHaveOrIWantAmountNullError =
    "Please enter I have or I want amount";

const String kCurrencyNullError = "Please select currency";
const String kCurrencyPairNullError = "Please select currency pair";
const String kSendCurrencyNullError = "Please select send currency";
const String kReceiveCurrencyNullError = "Please select receive currency";

const String kRateNullError = "Please enter rate";
const String kBuyRateNullError = "Please enter buy rate";
const String kSellRateNullError = "Please enter sell rate";

const String kDateNullError = "Please select date";

const String kBankAccountNumberNullError = "Please enter bank account number";
const String kBankAccountNameNullError = "Please enter bank account full name";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
