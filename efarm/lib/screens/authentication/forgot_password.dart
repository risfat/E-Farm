import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/custom_snackbar.dart';
import '../../utils/app_constant.dart';
import '../../utils/config.dart';
import '../../utils/mixins.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with InputValidationMixin {
  final GlobalKey<FormState> resetKey = GlobalKey<FormState>();
  bool errorEmail = false;
  bool isSentEmail = false;
  final emailController = TextEditingController();



  Future resetPassword() async {

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

    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim()).then((value){

      isSentEmail = true;
      Navigator.pop(context);

    });

    //SnackBar for sent success
    if (context.mounted) {
      showCustomSnackBar(context: context, message: "Password Reset Mail Sent Successfully', 'Please check your email...", backgroundColor: Colors.green);
    }


  } on FirebaseAuthException catch (e) {

      var message = e.message;
      isSentEmail = false;
      Navigator.pop(context);

      showCustomSnackBar(context: context, message: "Password Reset Failed. $message .  Please Try Again...", backgroundColor: Colors.red);

    }

    setState(() {

    });

  }

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(Config.forgotPass),
                  ),
                  Positioned(
                    left: 15,
                    top: 55,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Forgot \nPassword?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Constant.primaryColor,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Text(
                    'Don\'t worry! It happens. Please enter the email address associated with your account. '),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: resetKey,
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
                                  fontSize: 13,
                                ),
                                textInputAction: TextInputAction.done,
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
                      const SizedBox(
                        height: 60,
                      ),

                      isSentEmail ?
                      MaterialButton(
                        height: 50,
                        minWidth: 320,
                        color: Constant.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {

                          Navigator.pop(context);

                        },
                        child:
                        const Text(
                          'Back To Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,

                          ),
                        ),
                      )
                          :
                      MaterialButton(
                        height: 50,
                        minWidth: 320,
                        color: Constant.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {

                          if (resetKey.currentState!.validate()) {

                            resetPassword();

                          }

                        },
                        child:
                        const Text(
                          'SEND',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,

                          ),
                        ),
                      )
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
