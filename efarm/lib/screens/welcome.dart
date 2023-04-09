import 'package:efarm/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '../core/route_navigator.dart';
import 'authentication/login.dart';
import 'authentication/signup.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          if (snapshot.hasData){
            return const HomeScreen();
          }else{
            return SafeArea(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const FadeAnimation(
                            1,
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.2,
                            Text(
                              "Our app connects farmers directly with consumers, enabling farmers to sell their products directly to buyers. By listing their products on the app, farmers can reach interested buyers, making the supply chain more efficient and transparent.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[700], fontSize: 15),
                            )),
                      ],
                    ),
                    FadeAnimation(
                        1.4,
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  AssetImage('assets/images/e-farm-front.png'))),
                        )),
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.5,
                            MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                navigateToPage(context, const LoginPage(), AnimationType.slide);
                                // Get.to(() => const LoginPage(),
                                //     transition: Transition.downToUp);
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              padding: const EdgeInsets.only(bottom: 1, right: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: const Border(
                                  bottom: BorderSide(color: Colors.grey),
                                  top: BorderSide(color: Colors.grey),
                                  left: BorderSide(color: Colors.grey),
                                  right: BorderSide(color: Colors.grey),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x51000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () {
                                  navigateToPage(context, const SignUpPage(), AnimationType.slide);
                                },
                                color: Constant.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      )
    );
  }
}
