import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:swipe_app/utils/secrets.dart';

class SwipeServices {
  static Map<String, String> headers = {
    'Authorization' : AppSecrets.token,
    'Content-type' : 'application/json'
  };

  Future<http.Response> addCustomer(
      {required String customerId,
      required String customerName,
      required String customerEmail,
      required String customerPhone}) async {
    final url = Uri.https(AppSecrets.baseUrl,"/api/partner/v1/customer");
    log(url.toString(), name: "HITTING TO >>");
    Map<String, dynamic> customer = {
      "customer_id": customerId,
      "name": customerName,
      "phone": customerPhone,
      "email": customerEmail,
    };
    var response = await http.post(url,
    body: jsonEncode(customer),
    headers: headers);
    return response;
    // log(response.statusCode.toString(), name: "STATUS CODE >>");
    // log(response.body.toString(), name: "REASON >>");
    // if(response.statusCode == 201 || response.statusCode == 200){
    //   return true;
    // }else{
    //   return false;
    // }
  }

  Future<http.Response> getCustomers() async {
    final url = Uri.https(AppSecrets.baseUrl,"/api/partner/v1/customer/list");
    log(url.toString(), name: "HITTING TO >>");
    var response = await http.get(url,
        headers: headers);
    log(response.statusCode.toString(), name: "STATUS CODE >>");
    log(response.body.toString(), name: "REASON >>");
    return response;
  }

  createInvoice(String customerId, String customerName, String productId, String productName, int productQty, int productUnitPrice, int productWithTax, int netAmount) async {
    final url = Uri.https(AppSecrets.baseUrl,"/api/partner/v1/doc");
    log(url.toString(), name: "HITTING TO >>");
    Map<String, dynamic> invoice = {
      "document_type": "invoice",
      "document_date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "customer":
        {
          "id": customerId,
          "name": customerName
        }
      ,
      "items": [
        {
          "id": productId,
          "name": productName,
          "item_type": "goods",
          "quantity": productQty,
          "unit_price": productUnitPrice,
          "price_with_tax": productWithTax,
          "net_amount": netAmount,
          "total_amount": netAmount
        }
      ]
    };
    var response = await http.post(url,
        body: jsonEncode(invoice),
        headers: headers);
    log(invoice.toString(), name: "BODY >>");
    log(response.statusCode.toString(), name: "STATUS CODE >>");
    log(response.body.toString(), name: "REASON >>");
  }

}