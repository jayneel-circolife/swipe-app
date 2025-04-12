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
              return ListView.builder(itemBuilder: (context, index){
                Map<String, dynamic> customer = data['customers'][index];
                // log("${customer['customer_id']} ${customer['swipe_id']}");
                return ListTile(
                  title: Text(customer['name'].toString()),
                  subtitle: Text("${customer['customer_id'].toString()}  -- ${customer['swipe_id'].toString()}"),
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
