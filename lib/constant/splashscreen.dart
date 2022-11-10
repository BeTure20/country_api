import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:country_api/pages/homepage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 2500,
        splash: Column(children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Image.asset("assets/images/flutter_ui_dev_logo.png"),
          ),
        ]),
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 150,
        backgroundColor: Colors.white,
      ),
    );
  }
}
