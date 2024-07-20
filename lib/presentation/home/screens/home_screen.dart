import 'package:flutter/material.dart';
import 'package:swipe_app/presentation/customer/screens/add_customer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circolife Swipe App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCustomerScreen()));
              }, child: const Text("Add Customer")),
              ElevatedButton(onPressed: (){}, child: const Text("Add Product")),
              ElevatedButton(onPressed: (){}, child: const Text("Create Invoice")),
              ElevatedButton(onPressed: (){}, child: const Text("View Invoices"))
            ],
          ),
        ),
      ),
    );
  }
}
