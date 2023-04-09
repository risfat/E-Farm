import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingWidgetLottie extends StatelessWidget {
  const LoadingWidgetLottie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // The loading indicator
              // CircularProgressIndicator(),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Lottie.asset("assets/lottie/loading3.json"),
              ),
              // Some text
              const Text('Just A Moment...',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }
}
