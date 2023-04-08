import 'package:efarm/screens/authentication/signup.dart';
import 'package:efarm/screens/farmer/farmer_dashboard.dart';
import 'package:efarm/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/route_navigator.dart';
import '../../helper/custom_snackbar.dart';
import '../../utils/app_constant.dart';
import '../../utils/config.dart';
import '../../utils/mixins.dart';
import '../consumer/consumer_dashboard.dart';
import 'auth.dart';
import 'forgot_password.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with InputValidationMixin {
  bool _passwordVisible = false;
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool errorEmail = false;
  bool errorPass = false;

  String? errorMessage = '';
  bool isVerified = false;

  bool _isFarmerSelected = true;


  Future<void> signInWithEmailAndPassword(BuildContext context) async {

    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outside it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

        isVerified = true;

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });

      isVerified = false;

    }

  }


  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'eFarmer',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Constant.primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isFarmerSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                        ), backgroundColor: _isFarmerSelected ? Constant.primaryColor : Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                      ),
                      child: const Text(
                        'Farmer Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isFarmerSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                        ), backgroundColor: !_isFarmerSelected ? Constant.primaryColor : Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      ),
                      child: const Text(
                        'Consumer Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              backgroundColor: Constant.primaryColor,
              child: Icon(Icons.lock_outline, color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                _isFarmerSelected ? "Farmer Login" : "Consumer Login",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: loginformKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        !errorEmail
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.alternate_email_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(bottom: 50),
                                child: Icon(
                                  Icons.alternate_email_outlined,
                                  color: Constant.primaryColor,
                                  size: 20,
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              // ignore: body_might_complete_normally_nullable
                              validator: (email) {
                                if (isEmailValid(email!)) {
                                  setState(() {
                                    errorEmail = false;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    errorEmail = true;
                                  });
                                  return 'Enter valid Email';
                                }
                              },
                              decoration: const InputDecoration(
                                suffixIcon: SizedBox(),
                                errorStyle: TextStyle(fontSize: 10),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                hintText: 'Email ID',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        !errorPass
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.key_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(bottom: 50),
                                child: Icon(
                                  Icons.key_outlined,
                                  color: Constant.primaryColor,
                                  size: 20,
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (password) {
                                if (isLoginPasswordValid(password!)) {
                                  setState(() {
                                    errorPass = false;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    errorPass = true;
                                  });
                                  return 'Enter at least 8 character';
                                }
                              },
                              controller: passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(fontSize: 10),
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                                hintText: 'Password',
                                suffixIcon: !errorPass
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        child: _passwordVisible
                                            ? const Icon(
                                                Icons.visibility_off,
                                                size: 20,
                                              )
                                            : const Icon(
                                                Icons.visibility,
                                                size: 20,
                                              ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 28),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                          child: _passwordVisible
                                              ? const Icon(
                                                  Icons.visibility_off,
                                                  size: 20,
                                                )
                                              : const Icon(
                                                  Icons.visibility,
                                                  size: 20,
                                                ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            navigateToPage(context, const ForgotPasswordPage(), AnimationType.slide);
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Constant.primaryColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: 320,
                      color: Constant.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {

                        // signInWithEmailAndPassword(context).then((value){
                        //
                        //   // Close the dialog programmatically
                        //   Navigator.of(context).pop();
                        //   if (loginformKey.currentState!.validate() && isVerified) {
                        //
                        //     //SnackBar for login success
                        //     showCustomSnackBar(context: context, message: "Successfully logged in.", backgroundColor: Colors.green);
                        //
                        //     navigateToPage(context, const HomeScreen(), AnimationType.slide);
                        //
                        //
                        //   }else{
                        //     showCustomSnackBar(context: context, message: "Login failed. Please Try Again.", backgroundColor: Colors.red);
                        //   }
                        //
                        // });
                        
                        if (_isFarmerSelected) {
                          navigateToPage(context, FarmerDashboard(), AnimationType.slide);
                        }else{
                          navigateToPage(context, const ConsumerDashboard(), AnimationType.slide);
                        }

                      },
                      child:
                          const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: SizedBox(
                            height: 5,
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 5,
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Image.asset(Config.googleicon),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                'Login with Google',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New to E-Farm?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            navigateToPage(context, const SignUpPage(), AnimationType.slide);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(color: Constant.primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
