import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:swipe_app/utils/secrets.dart';
import 'package:swipe_app/utils/swipe_services.dart';

class CheckOrdersScreen extends StatefulWidget {
  const CheckOrdersScreen({super.key});

  @override
  State<CheckOrdersScreen> createState() => _CheckOrdersScreenState();
}

class _CheckOrdersScreenState extends State<CheckOrdersScreen> {
  TextEditingController customerIdController = TextEditingController();
  bool dataReady = false;
  bool swipeDataReady = false;
  int total = 0;
  Map<String, dynamic> data = {};
  List<dynamic> orders = [];
  List<dynamic> subscriptions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                maxLength: 17,
                controller: customerIdController,
              ),
            ),
            IconButton(
                onPressed: () {
                  searchOrders();
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (dataReady) ...[
                ListView.builder(
                  itemBuilder: (context, index) {
                    Map<String, dynamic> order = orders[index];
                    total += int.parse(order["monthlyPayment_amount"].toString());
                    return ListTile(
                      title: Text(order["model"]),
                      subtitle: Text("${order["deviceid"] ?? "not found"}"),
                      trailing: Text(order["monthlyPayment_amount"].toString(), style: const TextStyle(fontSize: 15),),
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                ),
                ElevatedButton(onPressed: (){
                  Fluttertoast.showToast(msg: "Total Amount : ${total}");
                }, child: const Text("Check Total")),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  swipeSubscriptions(customerIdController.text.toString());
                }, child: const Text("Check Swipe Subscriptions")),
                const SizedBox(height: 20,),
                if(swipeDataReady)...[
                  ListView.separated(
                    itemBuilder: (context, index) {
                      Map<String, dynamic> subscription = subscriptions[index];
                      return Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(subscription["hash_id"],style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            Text("Rs. ${subscription["total_amount"].toString()}",style: const TextStyle(fontSize: 15),),
                            Text("${subscription["subscription_start_time"]}  -  ${subscription["subscription_end_time"]}",style: const TextStyle(fontSize: 15),),
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subscriptions.length, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
                  ),
                ]

              ] else
                const Text("No Data"),
            ],
          ),
        ),
      ),
    );
  }

  createDBSubscriptions() async {
    for (Map<String, dynamic> order in orders) {
      if (true) {
        Map<String, dynamic> subscription = {
          "order_id": order['_id'],
          "ac_type": "Split",
          "customer_id": order['customer_id'],
          "customer_phone": order['mobile'],
          "customer_email": order['email'],
          "customer_name": order['Fullname'],
          "subscription_price": order['monthlyPayment_amount'],
          "plan_year": 3.2,
          "swipe_subscription_id": "SUBxZzEWC1lG",
          "subscription_start_date": "2024-01-24T00:00:00Z",
          "subscription_end_date": "2029-01-23T00:00:00Z",
          "deviceid": order['deviceid'],
          "ac_ton": order['model']
        };
        dev.log(subscription.toString(), name: "Subscription obj>");
        final postUrl = Uri.https(AppSecrets.url, "/api/subscription/postdatausingswipe/get");
        var subscriptionResponse = await http.post(postUrl, headers: SwipeServices.prodHeaders, body: jsonEncode(subscription));
        dev.log(subscriptionResponse.statusCode.toString(), name: "Subscriptions Post Response ${order['deviceid']}");
      }
    }
  }

  void swipeSubscriptions(String customerId) async {
    String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    dev.log(todayDate, name: 'Today Date >');
    final url = Uri.parse("https://${AppSecrets.baseUrl}/api/partner/v2/subscriptions/list?start_date=01-01-2023&end_date=$todayDate&status=all&customer_id=$customerId" );
    var swipeResponse = await http.get(url, headers: SwipeServices.prodHeaders);
    if(swipeResponse.statusCode == 200 || swipeResponse.statusCode == 201){
    var data = jsonDecode(swipeResponse.body.toString());
      if(data["data"]["total_records"] == 0 ){
        Fluttertoast.showToast(msg: "No Subscriptions!");
      }else{
        setState(() {
          swipeDataReady = true;
          subscriptions = data["data"]["transactions"];
          dev.log(subscriptions.toString());
        });
      }

    }else{
      Fluttertoast.showToast(msg: "Something went wrong", );
    }

  }


  void searchOrders() async {
    dev.log(customerIdController.text.toString(), name: "CUSTOMER ID >");
    var response = await http.get(Uri.https(AppSecrets.url, "/api/orders/getorderbycustomerid/${customerIdController.text.toString()}"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        total = 0;
        dataReady = true;
        Map<String, dynamic> data = jsonDecode(response.body);
        orders = data['data'];
      });
    } else {

    }
  }
}
