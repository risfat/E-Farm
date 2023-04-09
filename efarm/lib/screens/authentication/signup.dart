import 'package:efarm/screens/authentication/login.dart';
import 'package:efarm/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../core/route_navigator.dart';
import '../../helper/custom_snackbar.dart';
import '../../utils/config.dart';
import '../../utils/mixins.dart';
import '../../widgets/slideable_button.dart';
import '../consumer/consumer_dashboard.dart';
import '../farmer/farmer_dashboard.dart';
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
  final passController = TextEditingController();
  final addressController = TextEditingController();
  final GlobalKey<FormState> signUPKey = GlobalKey<FormState>();

  bool errorEmail = false;
  bool errorName = false;
  bool errorPhone = false;
  bool errorPass = false;
  bool errorAddress = false;
  bool _passwordVisible = false;

  bool agree = false;
  bool _isFarmerSelected = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passController.dispose();
    phoneController.dispose();
  }

  void _register(String name, String phone, String email, String password, String address, String type) async {

    if (context.mounted) {
      final authBloc = BlocProvider.of<AuthenticationBloc>(context);
      authBloc.add(
        RegisterUser(name: name, phone: phone, email: email, password: password, address: address, type: type),
      );

    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          // showCustomSnackBar(context: context, message: "Sign Up Success");
          return state.user.type == 'Farmer' ? FarmerDashboard() : const ConsumerDashboard();
        }
        if (state is Loading) {
          return Scaffold(
            body: Dialog(
              // The background color
              backgroundColor: Constant.primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Your Account is Being Created.\nPlease Wait...',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
              ),
            ),
          );
        }
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
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 47,
                                  child: TextFormField(
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    controller: emailController,
                                    onChanged: (s){
                                      errorEmail = false;
                                    },
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
                                        return 'Enter Valid Email Address';
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
                                      hintText: 'Email Address',
                                    ),
                                  ),
                                ),
                                state is Error ?
                                state.error.errors.containsKey("email") ?
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(state.error.errors['email'].toString(),style: const TextStyle(color: Colors.red),),
                                )
                                    : Container()
                                    :
                                Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: errorEmail && !errorPhone
                            ? 0
                            : !errorEmail && !errorPhone
                            ? 13
                            : 15,
                      ),
                      Row(
                        children: [
                          !errorPhone
                              ? const Icon(
                            Icons.verified_user,
                            color: Colors.grey,
                            size: 20,
                          )
                              : const Padding(
                            padding: EdgeInsets.only(bottom: 47),
                            child: Icon(
                              Icons.verified_user,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 47,
                                  child: TextFormField(
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),

                                    textInputAction: TextInputAction.next,
                                    controller: phoneController,
                                    textCapitalization: TextCapitalization.words,
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (number) {
                                      if (isPhoneValid(number!)) {
                                        setState(() {
                                          errorPhone = false;
                                        });
                                        return null;
                                      } else {
                                        setState(() {
                                          errorPhone = true;
                                        });
                                        return 'Enter A Valid Phone';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: errorPhone
                                          ? const EdgeInsets.only(bottom: 18)
                                          : const EdgeInsets.all(0.0),
                                      // suffixIcon: SizedBox(),
                                      errorStyle: const TextStyle(fontSize: 10),
                                      hintStyle: const TextStyle(
                                        fontSize: 13,
                                      ),
                                      hintText: 'Phone Number',
                                    ),
                                  ),
                                ),
                                state is Error ?
                                state.error.errors.containsKey("phone") ?
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(state.error.errors['phone'].toString(),style: const TextStyle(color: Colors.red),),
                                )
                                    : Container()
                                    :
                                Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: errorEmail && errorPhone && !errorName
                            ? 0
                            : !errorEmail && !errorPhone && !errorName
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
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
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
                                      // if (state is Error) {
                                      //   if (state.error.errors.containsKey("name")) {
                                      //     errorName = true;
                                      //     return state.error.errors["name"].toString();
                                      //   }
                                      // }
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
                                state is Error ?
                                state.error.errors.containsKey("name") ?
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(state.error.errors['name'].toString(),style: const TextStyle(color: Colors.red),),
                                )
                                    : Container()
                                    :
                                Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                        errorEmail && errorPhone && errorName && !errorAddress
                            ? 22
                            : !errorEmail &&
                            !errorPhone &&
                            !errorName &&
                            !errorAddress
                            ? 5
                            : 15,
                      ),
                      Row(
                        children: [
                          !errorAddress
                              ? const Icon(
                            Icons.location_city,
                            color: Colors.grey,
                            size: 20,
                          )
                              : const Padding(
                            padding: EdgeInsets.only(bottom: 47),
                            child: Icon(
                              Icons.location_city,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 47,
                                  child: TextFormField(
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),

                                    textInputAction: TextInputAction.next,
                                    controller: addressController,
                                    textCapitalization: TextCapitalization.words,
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (address) {
                                      // if (state is Error) {
                                      //   if (state.error.errors.containsKey("name")) {
                                      //     errorName = true;
                                      //     return state.error.errors["name"].toString();
                                      //   }
                                      // }
                                      if (address != '') {
                                        setState(() {
                                          errorAddress = false;
                                        });
                                        return null;
                                      } else {
                                        setState(() {
                                          errorAddress = true;
                                        });
                                        return 'Enter Valid Address';
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
                                      hintText: 'Address',
                                    ),
                                  ),
                                ),
                                state is Error ?
                                state.error.errors.containsKey("address") ?
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(state.error.errors['address'].toString(),style: const TextStyle(color: Colors.red),),
                                )
                                    : Container()
                                    :
                                Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                        errorEmail && errorPhone && errorName && !errorPass && errorAddress
                            ? 22
                            : !errorEmail &&
                            !errorPhone &&
                            !errorName &&
                            !errorPass &&
                            !errorAddress
                            ? 5
                            : 15,
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
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    validator: (password) {
                                      // if (state is Error) {
                                      //   if (state.error.errors.containsKey("password")) {
                                      //     setState(() {
                                      //       errorPass = true;
                                      //     });
                                      //     return state.error.errors["password"].toString();
                                      //   }
                                      // }
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
                                    controller: passController,
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
                                state is Error ?
                                state.error.errors.containsKey("password") ?
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(state.error.errors['password'].toString(),style: const TextStyle(color: Colors.red),),
                                )
                                    : Container()
                                    :
                                Container()
                              ],
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
                              Checkbox(
                                value: agree,
                                activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  setState(() {
                                    agree = value ?? false;
                                  });
                                },
                              ),
                              const Text(
                                'By signing up, you\'re agree to our ',
                                style: TextStyle(
                                  letterSpacing: 0.1,
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Helper().launchURL('${serverUrl}terms-condition');
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
                              const SizedBox(
                                width: 45,
                              ),
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
                                  // Helper().launchURL('${serverUrl}privacy-policy');
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
                        height: 55,
                        minWidth: 350,
                        color: Constant.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          if (agree) {
                            if (signUPKey.currentState!.validate()) {


                              _register(nameController.text, phoneController.text, emailController.text, passController.text, addressController.text, _isFarmerSelected ? 'Farmer' : 'Consumer');

                            }

                          }else{
                            showCustomSnackBar(context: context, message: "To create your account, please read and accept our terms and conditions. Thank you for choosing to be a part of our community. ", backgroundColor: Colors.redAccent);
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
  },
);
  }
}
