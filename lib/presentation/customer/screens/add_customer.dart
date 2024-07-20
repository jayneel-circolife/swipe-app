import 'dart:developer';

import 'package:flutter/material.dart';

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
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            ElevatedButton(onPressed: (){
              log(customerIdController.text, name: "Customer ID >>");
              log(nameController.text, name: "Name >>");
              log(phoneController.text, name: "Phone >>");
              log(emailController.text, name: "Email >>");


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
