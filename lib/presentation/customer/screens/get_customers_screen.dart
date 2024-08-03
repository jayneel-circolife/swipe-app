import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_app/utils/swipe_services.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SwipeServices().getCustomers(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData){
              Map<String, dynamic> data = jsonDecode(snapshot.data!.body);
              log(data.toString(), name: "Data =>");
              log(data['total_records'].toString(), name: "Count =>");
              // log(data['total_records'].runtimeType.toString(), name: "Data Type =>");
              return ListView.builder(itemBuilder: (context, index){
                Map<String, dynamic> customer = data['customers'][index];
                return (customer["customer_id"] == null) ? Container():
                ListTile(
                  title: Text(customer['name']),
                  subtitle: Text(customer['customer_id']),
                );
              }, itemCount: data['total_records'], shrinkWrap: true,);
            }
          }
          return const Text("ISSUE");
        },
      )
    );
  }
}
