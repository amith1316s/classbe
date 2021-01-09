import 'package:classbe/constants.dart';
import 'package:classbe/navigator.dart';
import 'package:classbe/routes.dart';
import 'package:classbe/screens/sign_in/sign_in_screen.dart';
import 'package:classbe/screens/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
          title: 'class Be',
          theme: theme(),
          // initialRoute: SplashScreen.routeName,
          navigatorKey: NavigatorGlobalKey.navigatorKey,
          routes: routes,
          home: SplashScreen(
              seconds: 4,
              navigateAfterSeconds: SignInScreen(),
              title: new Text(
                'ClassBe',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              image: new Image.asset('assets/logo_hat.png'),
              backgroundColor: kMainPrimaryColor,
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 100.0,
              loaderColor: Colors.white)),
    );
  }
}
