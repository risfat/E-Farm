import 'package:efarm/screens/authentication/login.dart';
import 'package:efarm/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/route_navigator.dart';
import '../../utils/config.dart';
import '../../utils/mixins.dart';
import '../../widgets/slideable_button.dart';
import '../home_screen.dart';

class SignUpPage extends StatefulWidget with InputValidationMixin {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with InputValidationMixin {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> signUPKey = GlobalKey<FormState>();

  bool errorEmail = false;
  bool errorName = false;
  bool errorPhone = false;

  bool _isFarmerSelected = true;


  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Farmer SignUp',
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
                          'Consumer SignUp',
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
                  _isFarmerSelected ? "Farmer Sign Up" : "Consumer Sign Up",
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
                key: signUPKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          !errorEmail
                              ? const Icon(
                                  Icons.alternate_email_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(bottom: 47),
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
                              height: 47,
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                                keyboardType: TextInputType.emailAddress,
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
                                    return 'Enter valid University Email';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: errorEmail
                                      ? const EdgeInsets.only(bottom: 18)
                                      : const EdgeInsets.all(0.0),
                                  // suffixIcon: SizedBox(),
                                  errorStyle: const TextStyle(fontSize: 10),
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  hintText: 'Email ID',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: errorEmail && !errorName
                            ? 0
                            : !errorEmail && !errorName
                                ? 13
                                : 15,
                      ),
                      Row(
                        children: [
                          !errorName
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(bottom: 47),
                                  child: Icon(
                                    Icons.person,
                                    color: Constant.primaryColor,
                                    size: 20,
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 47,
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 13,
                                ),

                                textInputAction: TextInputAction.next,
                                controller: nameController,
                                textCapitalization: TextCapitalization.words,
                                // ignore: body_might_complete_normally_nullable
                                validator: (name) {
                                  if (isNameValid(name!)) {
                                    setState(() {
                                      errorName = false;
                                    });
                                    return null;
                                  } else {
                                    setState(() {
                                      errorName = true;
                                    });
                                    return 'Enter Valid Name';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: errorName
                                      ? const EdgeInsets.only(bottom: 18)
                                      : const EdgeInsets.all(0.0),
                                  // suffixIcon: SizedBox(),
                                  errorStyle: const TextStyle(fontSize: 10),
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  hintText: 'Full Name',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: errorPhone && !errorName
                            ? 22
                            : errorName
                                ? 5
                                : 15,
                      ),
                      Row(
                        children: [
                          !errorPhone
                              ? const Icon(
                                  Icons.call,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(bottom: 47),
                                  child: Icon(
                                    Icons.call,
                                    color: Constant.primaryColor,
                                    size: 20,
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 47,
                              child: TextFormField(
                                maxLength: 11,

                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                controller: phoneController,
                                // ignore: body_might_complete_normally_nullable
                                validator: (phone) {
                                  if (isNameValid(phone!)) {
                                    setState(() {
                                      errorPhone = false;
                                    });
                                    return null;
                                  } else {
                                    setState(() {
                                      errorPhone = true;
                                    });
                                    return 'Enter Valid Phone';
                                  }
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding: errorPhone
                                      ? const EdgeInsets.only(bottom: 18)
                                      : const EdgeInsets.all(0.0),
                                  // suffixIcon: SizedBox(),
                                  errorStyle: const TextStyle(fontSize: 10),
                                  hintStyle: const TextStyle(
                                    fontSize: 13,
                                  ),
                                  hintText: 'Mobile',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'By Signing up, you\'re agree to our ',
                                style: TextStyle(
                                  letterSpacing: 0.1,
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   CupertinoPageRoute(
                                  //     builder: (context) =>
                                  //         const TermsandConditions(),
                                  //   ),
                                  // );
                                },
                                child: const Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                    color: Constant.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                ' and ',
                                style: TextStyle(
                                  letterSpacing: 0.1,
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   CupertinoPageRoute(
                                  //     builder: (context) =>
                                  //         const PrivacyPolicy(),
                                  //   ),
                                  // );
                                },
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    color: Constant.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: 350,
                        color: Constant.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          if (signUPKey.currentState!.validate()) {

                            debugPrint(emailController.text);
                            debugPrint(phoneController.text);
                            debugPrint(nameController.text);
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
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
                    'Joined Us Before?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        navigateToPage(context, const LoginPage(), AnimationType.slide);
                      },
                      child: const Text(
                        '  Login',
                        style: TextStyle(color: Constant.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
  }
}
