import 'package:efarm/utils/app_constant.dart';
import 'package:flutter/material.dart';


class HelperWidgets{

  void showLoadingDialog(BuildContext context) {
    showDialog(
      // The user CANNOT close this dialog  by pressing outside it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Constant.secondaryColor,
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
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }


}