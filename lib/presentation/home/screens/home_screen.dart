import 'package:flutter/material.dart';
import 'package:swipe_app/presentation/customer/screens/add_customer.dart';
import 'package:swipe_app/presentation/customer/screens/get_customers_screen.dart';
import 'package:swipe_app/presentation/invoice/screens/create_invoice.dart';
import 'package:swipe_app/presentation/invoice/screens/view_invoices.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCustomerScreen()));
            },child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add_alt_1_rounded),
                SizedBox(width: 10,),
                Text("Add Customer"),
              ],
            )),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerListScreen()));
            }, child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt_rounded),
                SizedBox(width: 10,),
                Text("Get Customers List"),
              ],
            )),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateInvoice()));
            }, child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_comment_rounded),
                SizedBox(width: 10,),
                Text("Create Invoice"),
              ],
            )),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewInvoicesScreen()));
            }, child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long_rounded),
                SizedBox(width: 10,),
                Text("View Invoices"),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
