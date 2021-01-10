import 'package:classbe/constants.dart';
import 'package:classbe/screens/home/home_screen.dart';
import 'package:classbe/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
  }

  Widget _buildImage(String assetName) {
    return Align(
        child: Container(
      width: 280,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: kMainPrimaryColor),
      child: Row(
        children: [
          Image.asset(
            'assets/logo_hat.png',
            width: 100,
            height: 100,
          ),
          Image.asset(
            'assets/logo_name.png',
            width: 100,
            height: 100,
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: IntroductionScreen(
            key: introKey,
            pages: [
              PageViewModel(
                title: "ClassBe",
                body: "Best Teachers.",
                image: _buildImage('logo_hat'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "ClassBe",
                body: "Best quality videos.",
                image: _buildImage('logo_hat'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "ClassBe",
                body: "Documents.",
                image: _buildImage('logo_hat'),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            onSkip: () {
              Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
            },
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text('Skip'),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
