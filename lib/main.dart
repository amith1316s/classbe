import 'package:classbe/navigator.dart';
import 'package:classbe/routes.dart';
//import 'package:classbe/screens/home/home_screen.dart';
//import 'package:classbe/screens/sign_in/sign_in_screen.dart';
import 'package:classbe/screens/theme.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:classbe/screens/sign_in/sign_in_screen.dart';


Future<void> main() async {
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
          title: 'Remit Mama',
          theme: theme(),
          // initialRoute: SplashScreen.routeName,
          navigatorKey: NavigatorGlobalKey.navigatorKey,
          routes: routes,
          home: SplashScreen(
              seconds: 4,
              navigateAfterSeconds: SignInScreen(),
              title: new Text(
                'Welcome',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              image: new Image.asset('assets/logo_hat.png'),
              backgroundColor: Color.fromRGBO(29, 4, 48, 1),
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 100.0,
              loaderColor: Colors.white)),
    );
  }
}
