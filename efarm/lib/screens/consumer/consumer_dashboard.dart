import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/consumer_model.dart';
import '../../models/farmer_model.dart';
import '../../utils/app_constant.dart';
import '../../widgets/consumer/consumer_list.dart';
import '../../widgets/farmer/farmer_list.dart';

class ConsumerDashboard extends StatefulWidget {
  const ConsumerDashboard({super.key});

  @override
  _ConsumerDashboardState createState() => _ConsumerDashboardState();
}

class _ConsumerDashboardState extends State<ConsumerDashboard> {
  final TextEditingController _productionController = TextEditingController();
  String _production = '';

  void _submitProduction() {
    setState(() {
      _production = _productionController.text;
      _productionController.clear();
    });
  }

  final List<Farmer> _farmers = [    Farmer(      name: 'John Doe',      address: '123 Main St, Anytown, USA',      mobileNo: '+1 555-123-4567',      todaySupply: '50 kg',    ),    Farmer(      name: 'Jane Smith',      address: '456 Oak Ave, Anycity, USA',      mobileNo: '+1 555-987-6543',      todaySupply: '100 kg',    ),    Farmer(      name: 'Bob Johnson',      address: '789 Maple Blvd, Anyville, USA',      mobileNo: '+1 555-555-1212',      todaySupply: '25 kg',    ),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consumer's Dashboard",
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
                      'Today\'s Demand',
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
                        hintText: 'Enter demand in kg',
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
            "Consumer's Connection",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Constant.primaryColor,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: buildFarmerList(_farmers),
            ),
          )
        ],
      ),
    );
  }
}
