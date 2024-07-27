import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_app/utils/swipe_services.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController customerIdController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    bool response;

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
            ElevatedButton(onPressed: () async {
              log(customerIdController.text, name: "Customer ID >>");
              log(nameController.text, name: "Name >>");
              log(phoneController.text, name: "Phone >>");
              log(emailController.text, name: "Email >>");
              response = await SwipeServices().addCustomer(customerId: customerIdController.text.toString(), customerEmail: emailController.text.toString(), customerName: nameController.text.toString(), customerPhone: phoneController.text.toString());
              print(response.toString());
              if(response)
                const AlertDialog(
                title: Text("Customer Created successfully!" ),
              );
              }, child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Add Customer"),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
