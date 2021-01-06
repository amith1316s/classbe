import 'package:classbe/common_event.dart';
import 'package:classbe/constants.dart';
import 'package:classbe/components/default_button.dart';
import 'package:classbe/components/form_error.dart';
import 'package:classbe/screens/loader.dart';
import 'package:classbe/screens/password/forgot_password/forgot_password_screen.dart';
import 'package:classbe/screens/verification/verification_screen.dart';
import 'package:classbe/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> _errors = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String _email;
  bool _remember = false;

  void addError({String error}) {
    if (!_errors.contains(error))
      setState(() {
        _errors.add(error);
      });
  }

  void removeError({String error}) {
    if (_errors.contains(error))
      setState(() {
        _errors.remove(error);
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              Checkbox(
                value: _remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    _remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: kPrimaryColor),
                ),
              )
            ],
          ),
          FormError(errors: _errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                signIn();
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          SignInButton(
            Buttons.Google,
            onPressed: () {
              _signInWithGoogle();
            },
          ),
        ],
      ),
    );
  }

  void emailVerification() async {
    User user = FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
    Navigator.pushNamed(context, VerificationScreen.routeName,
        arguments: _email);
  }

  Future<void> signIn() async {
    Loader.showLoadingScreen(context, _keyLoader);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      final User user = userCredential.user;
      if (user != null) {
        setState(() {
          _email = user.email;

          if (user.emailVerified) {
            CommonEvent.isUserProfileInFirestore(context);
          } else {
            emailVerification();
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      Loader.stopLoadingScreen(context);
      if (e.code == 'user-not-found') {
        print('No user found for that email. Please Sign Up');
        _showSnackBar('No user found for that email. Please Sign Up');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _showSnackBar('Wrong password provided for that user.');
      }
    }
  }

  void _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    final User user = FirebaseAuth.instance.currentUser;

    if (user.emailVerified) {
      CommonEvent.isUserProfileInFirestore(context);
    } else {
      emailVerification();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.phonelink_lock, color: Colors.black),
        ),
      ),
      controller: _passwordController,
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: Icon(Icons.email_rounded, color: Colors.black),
        ),
      ),
      controller: _emailController,
    );
  }
}
