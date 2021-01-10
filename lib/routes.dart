import 'package:classbe/screens/calender/calender.dart';
import 'package:flutter/widgets.dart';
import 'package:classbe/screens/home/home_screen.dart';
import 'package:classbe/screens/otp/otp_screen.dart';
import 'package:classbe/screens/password/forgot_password/forgot_password_screen.dart';
import 'package:classbe/screens/password/new_password/new_password_screen.dart';
import 'package:classbe/screens/profile/add_profile/add_profile_screen.dart';
import 'package:classbe/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:classbe/screens/profile/view_profile/view_profile_screen.dart';
import 'package:classbe/screens/settings/settings_screen.dart';
import 'package:classbe/screens/sign_in/sign_in_screen.dart';
import 'package:classbe/screens/sign_up/sign_up_screen.dart';
import 'package:classbe/screens/terms_conditions/terms_conditions_screen.dart';
import 'package:classbe/screens/verification/verification_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  TermsAndConditionsScreen.routeName: (context) => TermsAndConditionsScreen(),
  AddProfileScreen.routeName: (context) => AddProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  NewPasswordScreen.routeName: (context) => NewPasswordScreen(),
  ViewProfileScreen.routeName: (context) => ViewProfileScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  VerificationScreen.routeName: (context) => VerificationScreen(),
  Calender.routeName: (context) => Calender()
};
