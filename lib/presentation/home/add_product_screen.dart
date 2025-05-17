import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:swipe_app/presentation/home/screens/select_devices_screen.dart';
import 'package:swipe_app/utils/gsheet_helper.dart';
import '../../models/SwipeCustomerModel.dart';
import '../../utils/secrets.dart';
import 'package:http/http.dart' as http;

class CreateSubscriptionScreen extends StatefulWidget {
  final SwipeCustomerModel customer;

  const CreateSubscriptionScreen({super.key, required this.customer});

  @override
  State<CreateSubscriptionScreen> createState() => _CreateSubscriptionScreenState();
}

class _CreateSubscriptionScreenState extends State<CreateSubscriptionScreen> {
  late GSheetHelper sheetLogger = GSheetHelper();
  static Map<String, String> headers = {'Authorization': AppSecrets.token, 'Content-type': 'application/json'};
  final List<String> segments = ['3+2 Year', '5 Year'];
  String selectedSegment = '3+2 Year';
  bool isLoading = false;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime? endDate;
  final Map<String, List<String>> skuCategories = {
    'Split': ['2 Ton', '1.5 Ton', '1 Ton'],
    'Cassette': ['3 Ton', '2Ton'],
  };

  final Map<String, List<int>> defaultPrices = {
    'Split': [1699, 1399, 1349],
    'Cassette': [2999, 2499],
  };

  final Map<String, int> quantityMap = {};
  final Map<String, TextEditingController> priceControllers = {};

  @override
  void initState() {
    super.initState();
    skuCategories.forEach((category, skus) {
      final prices = defaultPrices[category] ?? [];
      for (int i = 0; i < skus.length; i++) {
        final sku = skus[i];
        quantityMap[sku] = 0;
        final price = (i < prices.length) ? prices[i].toString() : '';
        priceControllers[sku] = TextEditingController(text: price);
      }
    });
    endDate = DateTime(
      startDate.year + (selectedSegment == '3+2 Year' ? 3 : 5),
      startDate.month,
      startDate.day - 1,
    );
    sheetInit();
  }

  sheetInit() async {
    await sheetLogger.init();
  }

  @override
  void dispose() {
    for (var controller in priceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  mapProduct(String acModel, int count, int price) {
    double unitPrice = price / 1.28;
    if (acModel == "1 Ton") {
      return {
        "id": "mlmc_5y_1t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner - 5Y 1T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": price,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": price * count,
      };
    } else if (acModel == "1.5 Ton") {
      return {
        "id": "mlmc_5y_1.5t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner - 5Y 1.5T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": price,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": price * count,
      };
    } else if (acModel == "2 Ton") {
      return {
        "id": "mlmc_5y_2t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner - 5Y 2T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": price,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": price * count,
      };
    } else if (acModel == "3 Ton") {
      return {
        "id": "mlmc_cassette_5y_3t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner 5Y 3T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": price,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": price * count,
      };
    } else if (acModel == "2Ton") {
      return {
        "id": "mlmc_cassette_5y_2t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner 5Y 2T_cassette",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": price,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": price * count,
      };
    }
  }

  map2YearProduct(String acModel, int count, int price) {
    if (acModel == "1 Ton") {
      double unitPrice = 899 / 1.28;
      return {
        "id": "mlmc_5y_1t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner - 5Y 1T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": 899,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": 899 * count,
      };
    } else if (acModel == "1.5 Ton") {
      double unitPrice = 899 / 1.28;
      return {
        "id": "mlmc_5y_1.5t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner - 5Y 1.5T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": 899,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": 899 * count,
      };
    } else if (acModel == "2 Ton") {
      double unitPrice = 1099 / 1.28;
      return {
        "id": "mlmc_5y_2t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner - 5Y 2T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": 1099,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": 1099 * count,
      };
    } else if (acModel == "3 Ton") {
      double unitPrice = 1999 / 1.28;
      return {
        "id": "mlmc_cassette_5y_3t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner 5Y 3T",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": 1999,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": 1999 * count,
      };
    } else if (acModel == "2Ton") {
      double unitPrice = 1499 / 1.28;
      return {
        "id": "mlmc_cassette_5y_2t_p",
        "name": "Monthly Leasing and Maintenance charges of Air Conditioner 5Y 2T_cassette",
        "quantity": count,
        "unit_price": unitPrice,
        "tax_rate": 28,
        "price_with_tax": 1499,
        "item_type": "Service",
        "net_amount": unitPrice * count,
        "total_amount": 1499 * count,
      };
    }
  }

  void handleProceed() {

    final selectedSkus = quantityMap.entries
        .where((entry) => entry.value > 0)
        .map((entry) => {'Tonnage': entry.key, 'quantity': int.parse(entry.value.toString()), 'price': int.parse(priceControllers[entry.key]?.text ?? '0')})
        .toList();
    if (quantityMap.entries.isEmpty) {
      Fluttertoast.showToast(msg: "Please select at least one AC");
      return;
    }
    setState(() {
      isLoading = true;
    });
    log('Selected SKUs: $selectedSkus');
    log('Selected Customer: ${widget.customer.toString()}');
    createBulkSubscriptions(widget.customer, startDate, endDate!, selectedSkus, selectedSegment);
  }

  createBulkSubscriptions(SwipeCustomerModel swipeCustomerModel, DateTime subscriptionStartDate, DateTime subscriptionEndDate,
      List<Map<String, dynamic>> tonnage, String plan) async {
    Map<String, dynamic> resFirstData = {};
    Map<String, dynamic> resData = {};
    int? firstAmount;
    int? secondAmount;
    DateTime? secondStartDate;
    DateTime? secondEndDate;
    final url = Uri.https(AppSecrets.baseUrl, "/api/partner/v2/doc");
    log(url.toString(), name: "HITTING TO >>");
    final addressUrl = Uri.https(AppSecrets.baseUrl, "/api/partner/v2/customer/${swipeCustomerModel.customerId}");
    var addressResponse = await http.get(addressUrl, headers: headers);
    Map<String, dynamic> customerResponse = jsonDecode(addressResponse.body)["data"][0];
    String gstResponse = customerResponse["gstin"].toString();
    Map<String, dynamic> shippingResponse = customerResponse["shipping_address"][0];
    // String dueDate = DateFormat('dd-MM-yyyy').format(DateFormat('d-MMM-yy').parse(data["Start Date"]).add(const Duration(days: 7)));

    Map<String, dynamic> firstInvoice = {
      "document_date": DateFormat('dd-MM-yyyy').format(subscriptionStartDate),
      "document_type": "subscription",
      "items": [for (Map<String, dynamic> items in tonnage) mapProduct(items["Tonnage"], items["quantity"], items["price"])],
      "is_subscription": true,
      "party": {
        "id": swipeCustomerModel.customerId,
        "name": swipeCustomerModel.name,
        "type": "customer",
        "phone_number": swipeCustomerModel.phone,
        "country_code": "91",
        "shipping_address": {
          "addr_id": shippingResponse["addr_id"],
          "address_line1": shippingResponse["address_line1"],
          "address_line2": shippingResponse["address_line2"],
          "city": shippingResponse["city"],
          "state": shippingResponse["state"].toString().split("-")[1],
          "country": "India",
          "pincode": shippingResponse["pincode"]
        },
      },
      "subscription_details": {
        "end_time": DateFormat('dd-MM-yyyy').format(subscriptionEndDate),
        "repeat": 1,
        "repeat_type": "months",
        "send_email": true,
        "send_sms": true,
        "start_time": DateFormat('dd-MM-yyyy').format(subscriptionStartDate)
      },
      "round_off": true,
      "notes": "Start Date: ${DateFormat('dd-MM-yyyy').format(subscriptionStartDate)}      End Date: ${DateFormat('dd-MM-yyyy').format(subscriptionEndDate)}"
    };
    if (gstResponse == "") {
    } else {
      firstInvoice["party"]["gstin"] = gstResponse;
    }
    log(firstInvoice.toString(), name: "1st Invoice BoDY >");
    var firstResponse = await http.post(url, body: jsonEncode(firstInvoice), headers: headers);
    if (firstResponse.statusCode == 200 || firstResponse.statusCode == 201) {
      resFirstData = jsonDecode(firstResponse.body.toString())["data"];
      log("${resFirstData["serial_number"]} ->  ${resFirstData["hash_id"]}", name: swipeCustomerModel.customerId.toString());
      final items = firstInvoice['items'] as List<dynamic>;
      int sum = items.fold(0, (sum, item) => sum + (item['total_amount'] as num).round());
      firstAmount = sum;
      await sheetLogger.logData(
          customerId: swipeCustomerModel.customerId.toString(),
          serialNumber: resFirstData["serial_number"].toString(),
          hashId: resFirstData["hash_id"].toString(),
          startDate: DateFormat('dd-MM-yyyy').format(subscriptionStartDate),
          endDate: DateFormat('dd-MM-yyyy').format(subscriptionEndDate),
          customerName: swipeCustomerModel.name.toString(),
          amount: sum.toString());
      Fluttertoast.showToast(msg: "Subscription Created Successfully!", webPosition: "center");
    }

    DateTime startDate = DateTime(subscriptionEndDate.year, subscriptionEndDate.month, subscriptionEndDate.day +1);
    DateTime endDate = DateTime(startDate.year + 2, startDate.month, startDate.day);

    if (plan != "5 Year") {
      Map<String, dynamic> secondInvoice = {
        "document_date": DateFormat('dd-MM-yyyy').format(subscriptionStartDate),
        "document_type": "subscription",
        "items": [for (Map<String, dynamic> items in tonnage) map2YearProduct(items["Tonnage"], items["quantity"], items["price"])],
        "is_subscription": true,
        "party": {
          "id": swipeCustomerModel.customerId,
          "name": swipeCustomerModel.name,
          "type": "customer",
          "phone_number": swipeCustomerModel.phone,
          "country_code": "91",
          "shipping_address": {
            "addr_id": shippingResponse["addr_id"],
            "address_line1": shippingResponse["address_line1"],
            "address_line2": shippingResponse["address_line2"],
            "city": shippingResponse["city"],
            "state": shippingResponse["state"].toString().split("-")[1],
            "country": "India",
            "pincode": shippingResponse["pincode"]
          },
        },
        "subscription_details": {
          "end_time": DateFormat('dd-MM-yyyy').format(endDate),
          "repeat": 1,
          "repeat_type": "months",
          "send_email": true,
          "send_sms": true,
          "start_time": DateFormat('dd-MM-yyyy').format(startDate)
        },
        "round_off": true,
        "notes": "Start Date: ${DateFormat('dd-MM-yyyy').format(startDate)}      End Date: ${DateFormat('dd-MM-yyyy').format(endDate)}"
      };
      if (gstResponse == "") {
      } else {
        secondInvoice["party"]["gstin"] = gstResponse;
      }
      log(secondInvoice.toString(), name: "2st Invoice BoDY >");
      var secondResponse = await http.post(url, body: jsonEncode(secondInvoice), headers: headers);
      if (secondResponse.statusCode == 201 || secondResponse.statusCode == 200) {
        Fluttertoast.showToast(msg: "Second Subscription Created Successfully!!", webPosition: "center");
        resData = jsonDecode(secondResponse.body.toString())["data"];
        log("${resData["serial_number"]} ->  ${resData["hash_id"]}", name: swipeCustomerModel.customerId.toString());
        final items = secondInvoice['items'] as List<dynamic>;
        int sum = items.fold(0, (sum, item) => sum + (item['total_amount'] as num).round());
        secondAmount = sum;
        secondStartDate = startDate;
        secondEndDate = endDate;
        await sheetLogger.logData(
            customerId: swipeCustomerModel.customerId.toString(),
            serialNumber: resData["serial_number"].toString(),
            hashId: resData["hash_id"].toString(),
            startDate: DateFormat('dd-MM-yyyy').format(startDate),
            endDate: DateFormat('dd-MM-yyyy').format(endDate),
            customerName: swipeCustomerModel.name.toString(),
            amount: sum.toString());
      }
    }
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectDevicesScreen(
                  startDate: subscriptionStartDate,
                  customerModel: swipeCustomerModel,
                  endDate: subscriptionEndDate,
                  year: selectedSegment,
                  firstSubResponse: resFirstData,
                  secondSubResponse: resData,
                  firstAmount: firstAmount,
                  secondAmount: secondAmount,
                  secondStartDate: secondStartDate,
                  secondEndDate: secondEndDate,
                )));
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select ACs for ${widget.customer.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                width: size * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Plan",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SegmentedButton<String>(
                      segments: segments.map((label) => ButtonSegment(value: label, label: Text(label))).toList(),
                      selected: <String>{selectedSegment},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          selectedSegment = newSelection.first;
                          endDate = DateTime(
                            startDate.year + (selectedSegment == '3+2 Year' ? 3 : 5),
                            startDate.month,
                            (selectedSegment == '3+2 Year') ? startDate.day - 1 : startDate.day,
                          );
                        });
                      },
                      multiSelectionEnabled: false,
                      showSelectedIcon: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat("dd MMM yyyy").format(startDate),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(" - "),
                        Text(
                          DateFormat("dd MMM yyyy").format(endDate!),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              startDate = (await showDatePicker(context: context, firstDate: DateTime(2025, 1, 1), lastDate: DateTime(2055, 1, 1)))!;
                              setState(() {
                                endDate = DateTime(
                                  startDate.year + (selectedSegment == '3+2 Year' ? 3 : 5),
                                  startDate.month,
                                    (selectedSegment == '3+2 Year') ? startDate.day - 1 : startDate.day,
                                );
                              });
                            },
                            icon: const Icon(Icons.edit_calendar_outlined)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (var category in skuCategories.entries) ...[
                      Text(
                        category.key,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (var sku in category.value)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(sku, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text("Price: "),
                                  Expanded(
                                    child: TextField(
                                      controller: priceControllers[sku],
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      decoration: const InputDecoration(
                                        counterText: "",
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF879432))),
                                        hintText: "Enter price",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Quantity: "),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              setState(() {
                                                if (quantityMap[sku]! > 0) quantityMap[sku] = quantityMap[sku]! - 1;
                                              });
                                            },
                                          ),
                                          Text(quantityMap[sku].toString()),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                quantityMap[sku] = quantityMap[sku]! + 1;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 12),
                    ],
                    ElevatedButton(
                      onPressed: isLoading ? (){} : handleProceed,
                      style: ElevatedButton.styleFrom(backgroundColor:  isLoading ? Colors.grey : const Color(0xFFA14996), foregroundColor: Colors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Proceed"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // if(isLoading)...[
              //   Container(width: double.maxFinite, height: double.maxFinite, color: Colors.black12, child: Center(
              //     child: Lottie.asset("assets/anims/circolife_loader.json") ,
              //   ),)
              // ]


               ]
            ),
          ),
        ),
      ),
    );
  }
}
