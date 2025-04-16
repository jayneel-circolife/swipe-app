import 'package:flutter/material.dart';
import 'package:swipe_app/presentation/home/screens/check_orders_screen.dart';
import 'package:swipe_app/presentation/home/select_customer_screen.dart';
import 'package:swipe_app/utils/swipe_services.dart';

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo/logo.png",
                width: 200,
                height: 100,
              ),
              const SizedBox(
                height: 60,
              ),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCustomerScreen()));
              // },child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.person_add_alt_1_rounded),
              //     SizedBox(width: 10,),
              //     Text("Add Customer"),
              //   ],
              // )),
              // const SizedBox(height: 20,),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerListScreen()));
              // }, child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.list_alt_rounded),
              //     SizedBox(width: 10,),
              //     Text("Get Customers List"),
              //   ],
              // )),
              // const SizedBox(height: 20,),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => CreateInvoice()));
              // }, child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.add_comment_rounded),
              //     SizedBox(width: 10,),
              //     Text("Create Invoice"),
              //   ],
              // )),
              // const SizedBox(height: 20,),
              // ElevatedButton(onPressed: (){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewInvoicesScreen()));
              // }, child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.receipt_long_rounded),
              //     SizedBox(width: 10,),
              //     Text("View Invoices"),
              //   ],
              // )),
              // const SizedBox(height: 20,),
              // ElevatedButton(
              //     onPressed: () {
              //       SwipeServices().createBulkSubscriptions();
              //     },
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.subject_sharp),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text("Create Bulk Subscriptions"),
              //       ],
              //     )),
              // const SizedBox(
              //   height: 20,
              // ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOrdersScreen()));
              //     },
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.checklist_outlined),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text("Check Orders"),
              //       ],
              //     )),
              // const SizedBox(
              //   height: 20,
              // ),
              // ElevatedButton(onPressed: (){
              //   SwipeServices().updateCustomerId();
              // }, child: const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.receipt_long_rounded),
              //     SizedBox(width: 10,),
              //     Text("Update Customer Mappings"),
              //   ],
              // )),
              // ElevatedButton(onPressed: (){
              //   SwipeServices().pushToCustomer();
              // }, child: const Text("PUSH TO CUSTOMERS")),
              // ElevatedButton(
              //     onPressed: () {
              //       SwipeServices().extractSwipeId();
              //     },
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.currency_rupee),
              //         Text("Create Subscriptions"),
              //       ],
              //     )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectCustomerScreen()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_outlined),
                      Text(" Create Subscription ->"),
                    ],
                  )),

              // ElevatedButton(
              //     onPressed: () {
              //       SwipeServices().sendSubscriptions();
              //     },
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.currency_rupee),
              //         Text("DB Subscriptions"),
              //       ],
              //     )),
              // ElevatedButton(onPressed: (){
              //   SwipeServices().settleAmount();
              // }, child: const Text("SettleAmount"))
            ],
          ),
        ),
      ),
    );
  }
}
