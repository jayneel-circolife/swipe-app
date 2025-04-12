import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_app/presentation/customer/screens/get_customers_screen.dart';
import 'package:swipe_app/utils/swipe_services.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController customerIdController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Customer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: customerIdController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Customer ID",
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Name",
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: phoneController,
              maxLength: 10,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF262826)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Phone",
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(onPressed: () async {
          log(customerIdController.text, name: "Customer ID >>");
          log(nameController.text, name: "Name >>");
          log(phoneController.text, name: "Phone >>");
          log(emailController.text, name: "Email >>");
          var response = await SwipeServices().addCustomer(customerId: customerIdController.text.toString(), customerEmail: emailController.text.toString(), customerName: nameController.text.toString(), customerPhone: phoneController.text.toString());
          if(response.statusCode == 200 || response.statusCode == 201){
            Fluttertoast.showToast(msg: "Customer created Successfully");
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerListScreen()));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['error_code'])));
          }
          },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12), // Adjust the value as needed
            ),
            child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add Customer", style: TextStyle(fontSize: 22),),
          ],
        )),
      ),
    );
  }
}
