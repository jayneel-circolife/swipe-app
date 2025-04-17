import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:swipe_app/utils/secrets.dart';

class SwipeServices {
  final subscriptionList = [
    {
      "Tenure": "3+2",
      "Customer Name": "Fahim Siddique",
      "Billing Name": " Woodhome Furniture and interiors",
      "Registered number": 9920045455,
      "Tonnage": [
        {
          "Tonnage": "2 Ton",
          "QTY": 5,
          "Monthly Price": 1699,
          "Price At Renewal": 1099,
          "deviceIds": ["D4:8C:49:D5:93:A8", "D4:8C:49:D6:9F:FC", "8C:4F:00:0B:CA:2C", "D4:8C:49:D7:48:E8", "8C:4F:00:0B:F2:4C"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLWOO150325271201",
      "Email Id": "siddiquifahim455@gmail.com",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": "Santosh Bamne",
      "Billing Name": " Dwarka Veg Delight",
      "Registered number": 9892195249,
      "Tonnage": [
        {
          "Tonnage": "2 Ton",
          "QTY": 5,
          "Monthly Price": 1699,
          "Price At Renewal": 1099,
          "deviceIds": ["D4:8C:49:D7:5B:B0", "D4:8C:49:D7:14:40", "D4:8C:49:D7:00:74", "D4:8C:49:D7:93:CC", "8C:4F:00:0B:86:FC"]
        },
        {
          "Tonnage": "1.5 Ton",
          "QTY": 1,
          "Monthly Price": 1399,
          "Price At Renewal": 899,
          "deviceIds": ["8C:4F:00:0B:20:24"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLDWA240225271059",
      "Email Id": "dwarkavegdelight2024@gmail.com",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": "Tarun Vig",
      "Billing Name": " Kiran Bawa Hotels Pvt. Ltd.",
      "Registered number": 9820066169,
      "Tonnage": [
        {
          "Tonnage": "1.5 Ton",
          "QTY": 2,
          "Monthly Price": 1399,
          "Price At Renewal": 899,
          "deviceIds": ["D4:8C:49:D7:5F:0C", "8C:4F:00:0B:E1:80"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLKIR270325271296",
      "Email Id": "tarun.vig@bawagroup.in",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": "Dr Adil Qureshi",
      "Billing Name": " Dr Adil Qureshi",
      "Registered number": 9082340986,
      "Tonnage": [
        {
          "Tonnage": "1 Ton",
          "QTY": 1,
          "Monthly Price": 1349,
          "Price At Renewal": 899,
          "deviceIds": ["D4:8C:49:D5:6D:44"]
        },
        {
          "Tonnage": "1.5 Ton",
          "QTY": 1,
          "Monthly Price": 1399,
          "Price At Renewal": 899,
          "deviceIds": ["8C:4F:00:0C:02:D8"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-30",
      "Customer Id": "CLDRA020425271328",
      "Email Id": "dradilqureshipt@gmail.com",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": "Shanker",
      "Billing Name": "Hayaat Plus Medical",
      "Registered number": 7021602991,
      "Tonnage": [
        {
          "Tonnage": "2 Ton",
          "QTY": 2,
          "Monthly Price": 1699,
          "Price At Renewal": 1099,
          "deviceIds": ["D4:8C:49:D6:97:68"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLHAY180325271223",
      "Email Id": "hayaatplusmedical@gmail.com",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": "Sucheta Kulkarni",
      "Billing Name": "Capapie Sports Equipments",
      "Registered number": 8655887241,
      "Tonnage": [
        {
          "Tonnage": "1.5 Ton",
          "QTY": 2,
          "Monthly Price": 1399,
          "Price At Renewal": 899,
          "deviceIds": ["D4:8C:49:D6:42:B0", "8C:4F:00:0A:94:8C"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLCAP130924270227",
      "Email Id": "sucheta.kulkarni@capapiesports.org",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": "Shadab Rizwan Mirza",
      "Billing Name": "Royal Interior and Furniture Studio",
      "Registered number": 9004221621,
      "Tonnage": [
        {
          "Tonnage": "2 Ton",
          "QTY": 2,
          "Monthly Price": 1699,
          "Price At Renewal": 1099,
          "deviceIds": ["D4:8C:49:D7:6E:68", "8C:4F:00:0B:59:70", "D4:8C:49:D7:02:98"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLROY290325271316",
      "Email Id": "shaikhzuber7770@gmail.com",
      "gstin": ""
    },
    {
      "Tenure": "3+2",
      "Customer Name": " ",
      "Billing Name": "S.S.Collection",
      "Registered number": 9004221621,
      "Tonnage": [
        {
          "Tonnage": "2 Ton",
          "QTY": 2,
          "Monthly Price": 1699,
          "Price At Renewal": 1099,
          "deviceIds": ["D4:8C:49:D6:6C:58", "D4:8C:49:D5:A5:04"]
        }
      ],
      "Start Date": "28-Mar-25",
      "End Date": "27-Mar-28",
      "Customer Id": "CLSSC130225270993",
      "Email Id": "svikram98372.vs@gmail.com",
      "gstin": ""
    }
  ];

  final customerList = [];

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
    } else if (acModel == "Cassete 3 Ton") {
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
    } else if (acModel == "Cassete 2 Ton") {
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
    } else if (acModel == "Cassete 3 Ton") {
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
    } else if (acModel == "Cassete 2 Ton") {
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

  static Map<String, String> headers = {'Authorization': AppSecrets.token, 'Content-type': 'application/json'};
  static Map<String, String> apiHeaders = {'Accept': AppSecrets.token, 'Content-type': 'application/json'};

  Future<Map<String, String>> _getHeaderConfig() async {
    // String? token = await appStorage?.retrieveEncryptedData('token');
    Map<String, String> headers = {};
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // log(token.toString(), name: "Token>>>>>>");
    // if (token != null) {
    //   headers.putIfAbsent("Authorization", () => token);
    // }
    // log(headers.toString(), name: "IS EXISTING HEADERS");
    return headers;
  }
  static Map<String, String> prodHeaders = {
    'Authorization':
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMzE5ODU2LCJuYW1lIjoiQVBJIFVzZXIiLCJjb21wYW55X2lkIjoxMDM1MDcxLCJjb21wYW55X25hbWUiOiJQUk9DWU9OIFNUQVIgUFJJVkFURSBMSU1JVEVEIiwiaWF0IjoxNzIzNTc0MTYwLCJ2ZXJzaW9uIjoyLCJwYXJ0bmVyIjp0cnVlfQ.VUP0bbj0Pcb-IBOU1t8Fr87SrxochiisBqN_FvXMZOw",
    'Content-type': 'application/json'
  };

  List<Map<String, dynamic>> customersList = [];
  List<Map<String, dynamic>> debitList = [];

  Future<http.Response> addCustomer(
      {required String customerId, required String customerName, required String customerEmail, required String customerPhone}) async {
    final url = Uri.https(AppSecrets.baseUrl, "/api/partner/v1/customer");
    log(url.toString(), name: "HITTING TO >>");
    Map<String, dynamic> customer = {
      "customer_id": customerId,
      "name": customerName,
      "phone": customerPhone,
      "email": customerEmail,
    };
    var response = await http.post(url, body: jsonEncode(customer), headers: headers);
    return response;
    // log(response.statusCode.toString(), name: "STATUS CODE >>");
    // log(response.body.toString(), name: "REASON >>");
    // if(response.statusCode == 201 || response.statusCode == 200){
    //   return true;
    // }else{
    //   return false;
    // }
  }

  Future<http.Response> getOrders(String customerID) async {
    final url = Uri.https(AppSecrets.url, "/api/orders/getorderbycustomerid/$customerID");
    log(url.toString(), name: "HITTING TO >>");
    var response = await http.get(url, headers: await _getHeaderConfig());
    log(response.statusCode.toString(), name: "STATUS CODE >>");
    log(response.body.toString(), name: "REASON >>");
    return response;
  }


  Future<http.Response> getCustomers() async {
    final url = Uri.https(AppSecrets.baseUrl, "/api/partner/v2/customer/list");
    log(url.toString(), name: "HITTING TO >>");
    var response = await http.get(url, headers: prodHeaders);
    log(response.statusCode.toString(), name: "STATUS CODE >>");
    log(response.body.toString(), name: "REASON >>");
    return response;
  }

  Future<http.Response> isExistingCustomer({required String customerId}) async {
    final url = Uri.https(AppSecrets.baseUrl, "api/partner/v1/customer/$customerId");
    log(url.toString(), name: "HITTING TO >>");
    var response = await http.get(url, headers: {'Authorization': AppSecrets.token});
    return response;
  }

  Future<http.Response> isExistingProduct({required String productId}) async {
    final url = Uri.https(AppSecrets.baseUrl, "api/partner/v1/product/$productId");
    log(url.toString(), name: "HITTING TO >>");
    var response = await http.get(url, headers: {'Authorization': AppSecrets.token});
    return response;
  }

  createInvoice(
      {required String customerId,
      required String customerName,
      required String productId,
      required String productName,
      required int productQty,
      required double productUnitPrice,
      required double productWithTax,
      required double netAmount}) async {
    final url = Uri.https(AppSecrets.baseUrl, "/api/partner/v1/doc");
    log(url.toString(), name: "HITTING TO >>");
    Map<String, dynamic> invoice = {
      "document_type": "invoice",
      "document_date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "customer": {"id": customerId, "name": customerName},
      "items": [
        {
          "id": productId,
          "name": productName,
          "item_type": "goods",
          "quantity": productQty,
          "unit_price": productUnitPrice,
          "price_with_tax": productWithTax,
          "net_amount": netAmount,
          "total_amount": netAmount,
        }
      ]
    };
    var response = await http.post(url, body: jsonEncode(invoice), headers: headers);
    log(invoice.toString(), name: "BODY >>");
    log(response.statusCode.toString(), name: "STATUS CODE >>");
    log(response.body.toString(), name: "REASON >>");
  }

  updateCustomerId() async {
    final url = Uri.https(AppSecrets.baseUrl, "api/partner/v1/customer/list");
    final updateUrl = Uri.https(AppSecrets.baseUrl, "api/partner/v1/customer/list");
    var response = await http.get(url, headers: prodHeaders);
    Map<String, dynamic> data = jsonDecode(response.body);
    var customerList = data['customers'];
    for (int i = 509; i <= 516; i++) {
      Map<String, dynamic> data = customerList[i];
      log(data.toString(), name: "Index $i");
      String name = data['name'];
      String customerID = "CL${name.substring(0, 3).toUpperCase()}29112427${(i).toString().padLeft(4, "0")}";
      log(customerID);
      Map<String, dynamic> updateMap = {
        "customer_mapping": [
          {"customer_id": customerID, "swipe_id": data['swipe_id'], "force_update": true}
        ]
      };
      // var updateResponse = await http.post(updateUrl, headers: prodHeaders, body: jsonEncode(updateMap));
      // log(updateResponse.body.toString());
    }
  }

  pushToCustomer() async {
    final url = Uri.https(AppSecrets.baseUrl, "/api/partner/v2/product");
    for (int i = 0; i <= customersList.length; i++) {
      Map<String, dynamic> data = {
        "id": customersList[i]['id'],
        "name": customersList[i]['name'],
        "quantity": customersList[i]['quantity'],
        "unit_price": customersList[i]['unit_price'],
        "price_with_tax": customersList[i]['price_with_tax'],
        "item_type": customersList[i]['item_type'],
        "unit": "UNT"
      };
      var response = await http.put(url, headers: prodHeaders, body: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("success -> ", name: data["id"].toString());
      } else {
        log("error -> ", name: data["id"].toString());
        log(response.body, name: data["id"].toString());
        break;
      }
    }
  }

  // List customerList = [];
  extractSwipeId() async {
    List subscriptions = [];
    final url = Uri.https(AppSecrets.url, "/api/orders/getorderbycustomerid/CLRUP020125270729");
    var response = await http.get(url, headers: headers);
    log(response.statusCode.toString(), name: "Order Status Code >");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> orders = data['data'];
      for (Map<String, dynamic> order in orders) {
        if (checkDevices(order['deviceid']) || true) {
          Map<String, dynamic> subscription = {
            "order_id": order['_id'],
            "ac_type": "Split",
            "customer_id": order['customer_id'],
            "customer_phone": order['mobile'],
            "customer_email": order['email'],
            "customer_name": order['Fullname'],
            "subscription_price": order['monthlyPayment_amount'],
            "plan_year": 3.2,
            "swipe_subscription_id": "SUB4wMpNIM2R",
            "subscription_start_date": "2025-01-13T00:00:00Z",
            "subscription_end_date": "2028-01-12T00:00:00Z",
            "deviceid": order['deviceid'],
            "ac_ton": order['model']
          };
          log(subscription.toString(), name: "Subscription obj>");
          final postUrl = Uri.https(AppSecrets.url, "/api/subscription/postdatausingswipe/get");
          var subscriptionResponse = await http.post(postUrl, headers: prodHeaders, body: jsonEncode(subscription));
          log(subscriptionResponse.statusCode.toString(), name: "Subscriptions Post Response ${order['deviceid']}");

          Map<String, dynamic> secondSubscription = {
            "order_id": order['_id'],
            "ac_type": "Split",
            "customer_id": order['customer_id'],
            "customer_phone": order['mobile'],
            "customer_email": order['email'],
            "customer_name": order['Fullname'],
            "subscription_price": order['priceAtRenewal'],
            "plan_year": 3.2,
            "swipe_subscription_id": "SUBJp8P3I7Q0",
            "subscription_start_date": "2028-01-13T00:00:00Z",
            "subscription_end_date": "2030-01-13T00:00:00Z",
            "deviceid": order['deviceid'],
            "ac_ton": order['model']
          };
          // log(secondSubscription.toString(), name: "Subscription obj>");
          // var secondSubscriptionResponse = await http.post(postUrl, headers: prodHeaders, body: jsonEncode(secondSubscription));
          // log(secondSubscriptionResponse.statusCode.toString(), name: "Subscriptions Post Response ${order['deviceid']}");
        }
      }
      log(subscriptions.toString(), name: "Subscriptions >");
    }
  }

  checkDevices(String deviceId) {
    return [].contains(deviceId);
  }

  pushToInvoices() async {
    for (int i = 0; i <= customersList.length; i++) {
      final putUrl = Uri.https(AppSecrets.url, "/api/customer/customerID");
      final swipeURL =
          Uri.https(AppSecrets.baseUrl, "api/partner/v1/subscriptions/list?start_date=01-01-2023&end_date=12-12-2024&status=all&customer_id=customerID");
    }
  }

  settleAmount() async {
    final postUrl = Uri.https(AppSecrets.baseUrl, "api/partner/v2/payment");
    log("Total Records ${debitList.length}");
    for (int i = 0; i < debitList.length; i++) {
      Map<String, dynamic> settleData = {
        "amount": debitList[i]["Debit"],
        "payment_date": DateFormat('dd-MM-yyyy').format(DateTime.parse(debitList[i]["Date"])),
        "payment_mode": "UPI",
        "customer": debitList[i]["CUSTOMER ID"],
        "bank_details": {"account_number": "054605005280", "ifsc": "ICIC0000546", "bank_name": "ICICI Bank", "branch": "MUMBAIMAHAL"},
      };
      var settleResponse = await http.post(postUrl, headers: prodHeaders, body: jsonEncode(settleData));
      if (settleResponse.statusCode == 201 || settleResponse.statusCode == 200) {
        log("${debitList[i]["CUSTOMER ID"]} --> Done", name: "Success $i");
      } else {
        log("${debitList[i]["CUSTOMER ID"]} --> ${settleResponse.body.toString()} ", name: "Failed");
      }
    }
  }

  createBulkSubscriptions() async {
    final url = Uri.https(AppSecrets.baseUrl, "/api/partner/v2/doc");
    log(url.toString(), name: "HITTING TO >>");
    for (Map<String, dynamic> data in subscriptionList) {
      final addressUrl = Uri.https(AppSecrets.baseUrl, "/api/partner/v2/customer/${data["Customer Id"]}");
      var addressResponse = await http.get(addressUrl, headers: headers);
      Map<String, dynamic> customerResponse = jsonDecode(addressResponse.body)["data"][0];
      String gstResponse = customerResponse["gstin"].toString();
      Map<String, dynamic> shippingResponse = customerResponse["shipping_address"][0];
      // String dueDate = DateFormat('dd-MM-yyyy').format(DateFormat('d-MMM-yy').parse(data["Start Date"]).add(const Duration(days: 7)));

      Map<String, dynamic> firstInvoice = {
        "document_date": DateFormat('dd-MM-yyyy').format(DateFormat('d-MMM-yy').parse(data["Start Date"])),
        "document_type": "subscription",
        "items": [for (Map<String, dynamic> items in data["Tonnage"]) mapProduct(items["Tonnage"], items["QTY"], items["Monthly Price"])],
        "is_subscription": true,
        "party": {
          "id": data["Customer Id"],
          "name": data["Billing Name"],
          "type": "customer",
          "phone_number": data["Registered number"].toString(),
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
          "end_time": DateFormat('dd-MM-yyyy').format(DateFormat('d-MMM-yy').parse(data["End Date"])),
          "repeat": 1,
          "repeat_type": "months",
          "send_email": true,
          "send_sms": true,
          "start_time": DateFormat('dd-MM-yyyy').format(DateFormat('d-MMM-yy').parse(data["Start Date"]))
        },
        "round_off": true,
        "notes": "Start Date: ${data["Start Date"]}      End Date: ${data["End Date"]}"
      };
      if (gstResponse == "") {
      } else {
        firstInvoice["party"]["gstin"] = gstResponse;
      }
      log(firstInvoice.toString(), name: "1st Invoice BoDY >");
      var firstResponse = await http.post(url, body: jsonEncode(firstInvoice), headers: headers);
      // log(firstResponse.body.toString(), name: "First Subscription >>");
      if (firstResponse.statusCode == 200 || firstResponse.statusCode == 201) {
        Map<String, dynamic> resFirstData = jsonDecode(firstResponse.body.toString())["data"];
        log("${resFirstData["serial_number"]} ->  ${resFirstData["hash_id"]}", name: data["Customer Id"].toString());
      }

      DateTime startDate = DateFormat('d-MMM-yy').parse(data["End Date"]);
      startDate = startDate.add(const Duration(days: 1));
      DateTime endDate = startDate.add(const Duration(days: 731));

      // String dueDate2 = DateFormat('dd-MM-yyyy').format(startDate.add(const Duration(days: 7)));
      // log(dueDate, name: "Due Date>");

      if (data["Tenure"] != "5") {
        Map<String, dynamic> secondInvoice = {
          "document_date": DateFormat('dd-MM-yyyy').format(DateFormat('d-MMM-yy').parse(data["Start Date"])),
          "document_type": "subscription",
          "items": [for (Map<String, dynamic> items in data["Tonnage"]) map2YearProduct(items["Tonnage"], items["QTY"], items["Price At Renewal"])],
          "is_subscription": true,
          "party": {
            "id": data["Customer Id"],
            "name": data["Billing Name"],
            "type": "customer",
            "phone_number": data["Registered number"].toString(),
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
        // log(secondResponse.body.toString(), name: "Second Subscription >>");
        if (secondResponse.statusCode == 201 || secondResponse.statusCode == 200) {
          Map<String, dynamic> resData = jsonDecode(secondResponse.body.toString())["data"];
          log("${resData["serial_number"]} ->  ${resData["hash_id"]}", name: data["Customer Id"].toString());
        }
      }
    }
  }

  // createDbSubscription() async {
  //   final postUrl = Uri.https(AppSecrets.url, "/api/subscription/postdatausingswipe/get");
  //   for (Map<String, dynamic> data in subscriptionList) {
  //     Map<String, dynamic> dbSubscription = {
  //       "swipe_subscription_id": data["hashID"],
  //       "customer_id": data["Customer Id"],
  //       "customer_phone": data["Registered number"].toString(),
  //       "customer_email": data["Email Id"],
  //       "customer_name": data["Billing Name"],
  //       "subscription_price": "",
  //       "subscription_start_date": "2028-01-13T00:00:00Z",
  //       "subscription_end_date": "2030-01-13T00:00:00Z",
  //       "plan_year": data["Tenure"],
  //       "devices": [{}],
  //       "sub_serial_number": data["serial_number"]
  //     };
  //
  //     var secondResponse = await http.post(postUrl, body: jsonEncode(dbSubscription), headers: headers);
  //   }
  //
  //   // log(secondSubscription.toString(), name: "Subscription obj>");
  //   // var secondSubscriptionResponse = await http.post(postUrl, headers: prodHeaders, body: jsonEncode(secondSubscription));
  // }

  final postUrl = Uri.https(AppSecrets.url, "/api/subscription/postdatausingswipe/get");

  Future<void> sendSubscriptions() async {
    final headers = {"Content-Type": "application/json"};

    for (Map<String, dynamic> data in subscriptionList) {
      // Parse total plan years from tenure like "3+2"
      int planYear = data["Tenure"].toString().split("+").map((e) => int.tryParse(e.trim()) ?? 0).fold(0, (a, b) => a + b);

      // Parse dates
      DateFormat inputFormat = DateFormat("dd-MMM-yy");
      DateTime startDate = DateFormat("dd-MMM-yy").parse(data["Start Date"]);
      DateTime endDate = DateFormat("dd-MMM-yy").parse(data["End Date"]);

      // Calculate total subscription price (sum of all Monthly Prices × Qty)
      int totalPrice = 0;
      List<Map<String, dynamic>> devices = [];

      for (var tonnage in data["Tonnage"]) {
        int qty = tonnage["QTY"];
        int price = tonnage["Monthly Price"];
        totalPrice += price * qty;

        List<String> deviceIds = List<String>.from(tonnage["deviceIds"]);
        for (String deviceId in deviceIds) {
          devices.add({
            "deviceid": deviceId,
            "subscription_price": price,
            "ac_type": "Split", // Default; change if you have this info
            "ac_ton": tonnage["Tonnage"] == "1 Ton" ? "S10" : "S15"
          });
        }
      }

      Map<String, dynamic> dbSubscription = {
        "swipe_subscription_id": data["hashID"],
        "customer_id": data["Customer Id"],
        "customer_phone": data["Registered number"].toString(),
        "customer_email": data["Email Id"],
        "customer_name": data["Billing Name"],
        "subscription_price": totalPrice,
        "subscription_start_date": startDate.toIso8601String(),
        "subscription_end_date": endDate.toIso8601String(),
        "plan_year": planYear,
        "devices": devices,
        "sub_serial_number": data["serial_number"]
      };

      log(dbSubscription.toString(), name: "SUBSCRIPTION >");
      var response = await http.post(
        postUrl,
        body: jsonEncode(dbSubscription),
        headers: headers,
      );

      log("POST response (${response.statusCode}): ${response.body}");
    }
  }
}
