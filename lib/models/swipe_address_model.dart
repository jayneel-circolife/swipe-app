import 'package:flutter/material.dart';

class SwipeAddressModel {
  int? addrId;
  String? addrIdV2;
  String? addressLine1;
  String? addressLine2;
  String? pincode;
  String? city;
  String? state;
  String? country;

  SwipeAddressModel({this.addrId, this.addrIdV2, this.addressLine1, this.addressLine2, this.pincode, this.city, this.state, this.country});

  SwipeAddressModel.fromJson(Map<String, dynamic> json) {
    addrId = json['addr_id'];
    addrIdV2 = json['addr_id_v2'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addr_id'] = addrId;
    data['addr_id_v2'] = addrIdV2;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}
