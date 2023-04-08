import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:efarm/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../screens/welcome.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: AnimatedSplashScreen.withScreenFunction(
          splash: Column(
            children: [
              Container(
                height: 250,
                width: 350,
                transform: Matrix4.translationValues(-50.0, -100.0, 0.0),
                child: Lottie.asset("assets/lottie/splash.json", fit: BoxFit.cover),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -85.0, 0.0),
                child: Text(
                  'E - Farm',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sairaStencilOne(
                    fontSize: 30.0,
                    color: Constant.primaryColor,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, -78.0, 0.0),
                child: Text(
                  'Connecting farmers to your table',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.niconne(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),

          screenFunction: () async {
            return const WelcomePage();
          },
          splashTransition: SplashTransition.slideTransition,
        ),
      ),
    );
  }
}
