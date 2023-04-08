import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/consumer_model.dart';
import '../../utils/app_constant.dart';
import '../../widgets/consumer/consumer_list.dart';

class FarmerDashboard extends StatefulWidget {
  @override
  _FarmerDashboardState createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  final TextEditingController _productionController = TextEditingController();
  String _production = '';

  void _submitProduction() {
    setState(() {
      _production = _productionController.text;
      _productionController.clear();
    });
  }

  final List<Consumer> _consumers = [    Consumer(      name: 'John Doe',      address: '123 Main St, Anytown, USA',      mobileNo: '+1 555-123-4567',      todayDemand: '50 kg',    ),    Consumer(      name: 'Jane Smith',      address: '456 Oak Ave, Anycity, USA',      mobileNo: '+1 555-987-6543',      todayDemand: '100 kg',    ),    Consumer(      name: 'Bob Johnson',      address: '789 Maple Blvd, Anyville, USA',      mobileNo: '+1 555-555-1212',      todayDemand: '25 kg',    ),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: const Text(
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
              padding: EdgeInsets.all(16),
              child: buildConsumerList(_consumers),
            ),
          )
        ],
      ),
    );
  }
}
