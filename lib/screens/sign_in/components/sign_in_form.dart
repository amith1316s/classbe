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
//import 'package:classbe/utilities/constants.dart';

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
        child: Container(
          width: 400.0,
          child: Column(
            children: [
              Container(
                width: 300.0,
                child: Column(
                  children: [
                    buildEmailFormField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildPasswordFormField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
              Container(
                width: 300.0,
                child: Row(
                  children: [
                    Checkbox(
                      value: _remember,
                      activeColor: kMainPrimaryColor,
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
                            color: Colors.deepPurple[900],
                          ),
                        ))
                  ],
                ),
              ),
              FormError(errors: _errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              Container(
                width: 300.0,
                child: DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // if all are valid then go to success screen
                      signIn();
                    }
                  },
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(3)),
              //   _buildSignInWithText(),
              //  SizedBox(height: getProportionateScreenHeight(5)),
              //    SignInButton(
              //     Buttons.Google,
              //     onPressed: () {
              //       _signInWithGoogle();
              //     },
              //   ),
            ],
          ),
        ));
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
          child: Icon(Icons.phonelink_lock, color: kMainPrimaryColor),
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
          child: Icon(Icons.email_rounded, color: kMainPrimaryColor),
        ),
      ),
      controller: _emailController,
    );
  }
}

/*  Widget buildEmailFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
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
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: kMainPrimaryColor,
              ),
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            controller: _passwordController,
          ),
        ),
      ],
    );
  }
} */
/* 
Widget _buildPasswordTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextFormField(
          obscureText: true,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Enter your Password',
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
} */

/* Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: () => onTap,
    child: Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}

Widget _buildSocialBtnRow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
         _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ), 
         _buildSocialBtn(
          () => print('Login with Google'),
          AssetImage(
            'assets/logos/Google.jpg',
          ),
        ),
      ],
    ),
  );
} 
  */
Widget _buildSignInWithText() {
  return Column(
    children: <Widget>[
      SizedBox(height: 20.0),
      Text(
        'or - Sign in with',
        //style: kLabelStyle,
      ),
    ],
  );
}
