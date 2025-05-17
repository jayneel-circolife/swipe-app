import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_app/models/SwipeCustomerModel.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_app/presentation/home/select_customer_screen.dart';

import '../../../utils/secrets.dart';
import '../../../utils/swipe_services.dart';

class SelectDevicesScreen extends StatefulWidget {
  const SelectDevicesScreen(
      {super.key,
      required this.startDate,
      required this.customerModel,
      required this.endDate,
      required this.firstAmount,
      required this.secondAmount,
      required this.year,
      required this.firstSubResponse,
      required this.secondSubResponse,
      required this.secondStartDate,
      required this.secondEndDate});

  final DateTime startDate;
  final SwipeCustomerModel customerModel;
  final int? firstAmount;
  final int? secondAmount;
  final String year;
  final Map<String, dynamic> firstSubResponse;
  final Map<String, dynamic> secondSubResponse;
  final DateTime endDate;
  final DateTime? secondStartDate;
  final DateTime? secondEndDate;

  @override
  State<SelectDevicesScreen> createState() => _SelectDevicesScreenState();
}

class _SelectDevicesScreenState extends State<SelectDevicesScreen> {
  Map<String, Map<String, dynamic>> selectedDevices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Select Devices ${widget.firstSubResponse["hash_id"].toString()} ${widget.firstSubResponse["serial_number"].toString()} ${widget.firstAmount.toString()}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: SwipeServices().getOrders(widget.customerModel.customerId.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              List<dynamic> data = jsonDecode(snapshot.data!.body)["data"];

              if (selectedDevices.isEmpty) {
                for (var order in data) {
                  final deviceId = order["deviceid"].toString();
                  final price = order["monthlyPayment_amount"] ?? 0;
                  final tonnage = order["model"] ?? "S10";
                  final type = order["ac_type"] ?? "Split";

                  selectedDevices[deviceId] = {
                    "deviceid": deviceId,
                    "subscription_price": price,
                    "ac_ton": tonnage,
                    "ac_type": type,
                  };
                }
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final order = data[index];
                        final deviceId = order["deviceid"].toString();
                        final price = order["monthlyPayment_amount"] ?? 0;
                        final tonnage = order["model"] ?? "Unknown";
                        final type = order["ac_type"] ?? "Unknown";

                        final isChecked = selectedDevices.containsKey(deviceId);

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: ListTile(
                            title: Text("Device ID: $deviceId"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tonnage: $tonnage"),
                                Text("Monthly Price: ₹$price"),
                                Text("Installed: ${order["installationTimestamp"].toString().split("T")[0]}"),
                              ],
                            ),
                            trailing: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedDevices[deviceId] = {
                                      "deviceid": deviceId,
                                      "subscription_price": price,
                                      "ac_ton": tonnage,
                                      "ac_type": type,
                                    };
                                  } else {
                                    selectedDevices.remove(deviceId);
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA14996), foregroundColor: Colors.white),
                    onPressed: () async {
                      final selectedList = selectedDevices.values.toList();
                      log(jsonEncode(selectedList), name: "Selected Devices");
                      Map<String, dynamic> dbSubscription = {
                        "swipe_subscription_id": widget.firstSubResponse["hash_id"],
                        "customer_id": widget.customerModel.customerId,
                        "customer_phone": widget.customerModel.phone,
                        "customer_email": widget.customerModel.email,
                        "customer_name": widget.customerModel.name,
                        "subscription_price": int.parse(widget.firstAmount.toString()),
                        "subscription_start_date": widget.startDate.toIso8601String(),
                        "subscription_end_date": widget.endDate.toIso8601String(),
                        "plan_year": widget.year == "3+2 Year" ? 3.2 : 5,
                        "devices": selectedList,
                        "sub_serial_number": widget.firstSubResponse["serial_number"]
                      };
                      log(dbSubscription.toString(), name: "Selected Devices");

                      final postUrl = Uri.https(AppSecrets.url, "/api/subscription/postdatausingswipe/get");
                      final headers = {"Content-Type": "application/json"};
                      var response = await http.post(
                        postUrl,
                        body: jsonEncode(dbSubscription),
                        headers: headers,
                      );

                      Fluttertoast.showToast(msg: "POST response (${response.statusCode}): ${response.body}");
                      if (widget.year == "3+2 Year") {
                        Map<String, dynamic> dbSecondSubscription = {
                          "swipe_subscription_id": widget.secondSubResponse["hash_id"],
                          "customer_id": widget.customerModel.customerId,
                          "customer_phone": widget.customerModel.phone,
                          "customer_email": widget.customerModel.email,
                          "customer_name": widget.customerModel.name,
                          "subscription_price": int.parse(widget.secondAmount.toString()),
                          "subscription_start_date": widget.secondStartDate?.toIso8601String(),
                          "subscription_end_date": widget.secondEndDate?.toIso8601String(),
                          "plan_year": widget.year == "3+2 Year" ? 3.2 : 5,
                          "devices": selectedList,
                          "sub_serial_number": widget.secondSubResponse["serial_number"]
                        };
                        log(dbSubscription.toString(), name: "Selected Devices");

                        var secondResponse = await http.post(
                          postUrl,
                          body: jsonEncode(dbSecondSubscription),
                          headers: headers,
                        );
                        Fluttertoast.showToast(msg: "POST response (${secondResponse.statusCode}): ${secondResponse.body}");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectCustomerScreen(
                                      origin: "subscription",
                                    )));
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Proceed"),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text("Unable to load devices"));
          },
        ),
      ),
    );
  }
}
