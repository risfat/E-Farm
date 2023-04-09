import 'package:efarm/bloc/supply_demand_bloc/supply_demand_cubit.dart';
import 'package:efarm/helper/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../helper/custom_snackbar.dart';
import '../../helper/exit_confirmation_dialog.dart';
import '../../models/consumer_model.dart';
import '../../repositories/repository.dart';
import '../../utils/app_constant.dart';
import '../../widgets/consumer/consumer_list.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  final TextEditingController _productionController = TextEditingController();
  String _production = '';
  bool isLoading = false;

  void _submitProduction() {
    if (_productionController.text != '') {

      // Close the keyboard
      FocusScope.of(context).unfocus();

      setState(() {
        isLoading = true;
      });


      _production = _productionController.text;

      Repository().setSupplyDemand(supplyDemand: _production).then((value){
        if (value) {
          setState(() {
            isLoading = false;
          });
          _productionController.clear();
          showCustomSnackBar(
              context: context,
              message:
              "Today's Production Has Been Updated.",
              backgroundColor: Colors.green);
        }
      });
    }else{
      showCustomSnackBar(
          context: context,
          message:
          "Invalid Production Value.Please try again.",
          backgroundColor: Colors.redAccent);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ExitConfirmationDialog.buildExitConfirmationDialog(context);
          },
        ) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farmer Dashboard',
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
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                // Logout functionality
                if (context.mounted) {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    const LoggedOut(),
                  );
                  // Navigator.pushNamed(context, '/');
                  showCustomSnackBar(
                      context: context,
                      message: "You Have Been Successfully Logged Out",
                      backgroundColor: Colors.redAccent);
                }
              },
              child: const IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: null,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today\'s Production',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Constant.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _productionController,
                        decoration: InputDecoration(
                          hintText: 'Enter production in kg',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Constant.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitProduction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constant.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading ? const CircularProgressIndicator(color: Colors.white) :  const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Text(
                      //   'Previous Production Was: 110 kg',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: Colors.grey[700],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Farmer's Connection",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Constant.primaryColor,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: BlocProvider(
                  create: (context) =>
                  SupplyDemandCubit()
                    ..init(),
                  child: BlocBuilder<SupplyDemandCubit, SupplyDemandState>(
                    builder: (context, state) {

                      if (state.status == Status.failure) {
                        return const Center(
                            child: Text(
                              'Something went wrong! Please try again later.',
                              style: TextStyle(color: Colors.black45),
                            ));
                      }
                      if (state.status == Status.success) {
                        return buildConsumerList(state.users);
                      }

                      return const LoadingWidget();

                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
