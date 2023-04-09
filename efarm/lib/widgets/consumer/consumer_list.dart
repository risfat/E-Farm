import 'package:efarm/helper/helper.dart';
import 'package:efarm/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../models/consumer_model.dart';

Widget buildConsumerList(List<UserModel> consumers) {
  return ListView.builder(
    itemCount: consumers.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      UserModel consumer = consumers[index];
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consumer.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    consumer.address,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mobile No: ${consumer.phone}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Today\'s Demand: ${consumer.supplyDemand == '' ? 'None' :  consumer.supplyDemand}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Helper().launchURL("tel:${consumer.phone}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8BC34A),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Connect',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
