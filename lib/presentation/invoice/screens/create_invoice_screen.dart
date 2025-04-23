import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:swipe_app/models/SwipeCustomerModel.dart';

import '../../../utils/gsheet_helper.dart';
import '../../../utils/secrets.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key, required this.customer});
  final SwipeCustomerModel customer;

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
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
    getAddress();
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
    // createBulkSubscriptions(widget.customer, startDate, endDate!, selectedSkus, selectedSegment);
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
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                width: size * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Address",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                                  startDate.day,
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
                      onPressed: isLoading ? () {} : handleProceed,
                      style: ElevatedButton.styleFrom(backgroundColor: isLoading ? Colors.grey : const Color(0xFFA14996), foregroundColor: Colors.white),
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
            ]),
          ),
        ),
      ),
    );
  }

  void getAddress() async {}
}
