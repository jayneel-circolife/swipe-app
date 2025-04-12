import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_app/utils/swipe_services.dart';

class CreateInvoice extends StatefulWidget {
  CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  double totalAmount = 0;
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productQtyController = TextEditingController();
  final TextEditingController productUnitPriceController = TextEditingController();
  final TextEditingController productNetAmountController = TextEditingController();
  final TextEditingController productWithTaxController = TextEditingController();
  double productQty = 0;
  double netAmount = 0;
  late var customerList = [];

  @override
  void initState() {
    super.initState();
    // customerList = getCustomersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Customer", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: customerIdController,
                    onEditingComplete: () async {
                      var response = await SwipeServices().isExistingCustomer(customerId: customerIdController.text);
                      log(response.body, name: "RESPONSE >> ");
                      var body = jsonDecode(response.body);
                      log(body['customer_details']['name'], name: "NAME >>");
                      if(body["success"]){
                        customerNameController.text = body['customer_details']['name'];
                      }
                    },
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
                      hintText: "Customer Id",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: customerNameController,
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
                      hintText: "Customer Name",
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Product", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: productIdController,
                    onEditingComplete: () async {
                      var response = await SwipeServices().isExistingProduct(productId: productIdController.text);
                      log(response.body, name: "RESPONSE >> ");
                      var body = jsonDecode(response.body);
                      log(body['item'][0]['name'], name: "NAME >>");
                      if(body["success"]){
                        productNameController.text = body['item'][0]['name'];
                        productUnitPriceController.text = body['item'][0]['unit_price'].toString();
                        productWithTaxController.text = body['item'][0]['price_with_tax'].toString();
                      }
                    },
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
                      hintText: "Product Id",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: productNameController,
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
                      hintText: "Product Name",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: productUnitPriceController,
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
                      hintText: "Product Unit Price",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: productWithTaxController,
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
                      hintText: "Product with Tax",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    onChanged: (v){
                      setState(() {
                        totalAmount = double.parse(v) * double.parse(productWithTaxController.text);
                        productNetAmountController.text = totalAmount.toString();
                      });
                    },
                    controller: productQtyController,
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
                      hintText: "Product Quantity",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: productNetAmountController,
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
                      hintText: "Net Amount",
                      enabled: false
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Total Amount: ₹ ${totalAmount.toString()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12), // Adjust the value as needed
          ),
          onPressed: (){
           SwipeServices().createInvoice(customerId: customerIdController.text, customerName:customerNameController.text, productId: productIdController.text, productName:productNameController.text, productQty:int.parse(productQtyController.text), productUnitPrice: double.parse(productUnitPriceController.text), productWithTax:double.parse(productWithTaxController.text), netAmount: totalAmount);
            },
          child: const Text("Create Invoice", style: TextStyle(fontSize: 22),),
        ),
      ),
    );
  }
}
