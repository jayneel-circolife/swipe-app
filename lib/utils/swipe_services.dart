import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:swipe_app/utils/secrets.dart';

class SwipeServices {
  Future<http.Response> addCustomer(String customerId) async {
    final url = Uri.http("${AppSecrets.baseUrl}/v1/customer/$customerId");
    var response = await http.post(url,
    body: {},
    headers: {
      'Authorization' : AppSecrets.token,
      'Content-type' : 'application/json'
    });
    log(response.statusCode.toString(), name: "STATUS CODE >>");
    return response;
  }
}