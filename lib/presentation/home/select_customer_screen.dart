import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_app/presentation/home/add_product_screen.dart';

import '../../models/SwipeCustomerModel.dart';
import '../../utils/secrets.dart';
import '../../utils/swipe_services.dart'; // <-- Your next screen

class SelectCustomerScreen extends StatefulWidget {
  const SelectCustomerScreen({super.key});

  @override
  State<SelectCustomerScreen> createState() => _SelectCustomerScreenState();
}

class _SelectCustomerScreenState extends State<SelectCustomerScreen> {
  static Map<String, String> headers = {'Authorization': AppSecrets.token, 'Content-type': 'application/json'};
  List<SwipeCustomerModel> allCustomers = [];
  List<SwipeCustomerModel> filteredCustomers = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCustomer();
  }

  Future<void> fetchCustomers() async {
    final response = await SwipeServices().getCustomers();
    final data = jsonDecode(response.body)["data"];

    // log(data.toString(), name: "Data =>");

    List customersJson = data['customers'];
    allCustomers = customersJson
        .map((json) => SwipeCustomerModel.fromJson(json))
        .toList();

    setState(() {
      filteredCustomers = allCustomers;
      isLoading = false;
    });
  }

  getCustomer() async {
    await fetchCustomers();
  }

  void filterSearch(String query) {
    setState(() {
      filteredCustomers = allCustomers.where((customer) {
        final name = customer.name?.toLowerCase() ?? '';
        final id = customer.customerId?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) || id.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Customer")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: filterSearch,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCustomers.length,
              itemBuilder: (context, index) {
                final customer = filteredCustomers[index];
                return ListTile(
                  title: Text(customer.name ?? 'No Name'),
                  subtitle: Text(customer.customerId ?? "Unknown"),
                  onTap: () {
                    log(customer.toString(), name: "Selected Customer>");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreateSubscriptionScreen(customer: customer),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
