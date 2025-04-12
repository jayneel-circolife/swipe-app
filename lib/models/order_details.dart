class OrderDetails {
  String? oId;
  String? userid;
  String? longitude;
  String? latitude;
  String? city;
  String? area;
  String? flat;
  String? address;
  String? state;
  String? pincode;
  int? plan_year;
  String? model;
  String? paymentId;
  int? payment_amount;
  dynamic appointmentDate;
  dynamic orderingDate;
  String? Status;
  String? gst;
  String? billingaddress;
  String? companyname;
  int? remainingBalance;
  int? deposite;
  int? monthlyPayment_amount;
  int? quantity;

  OrderDetails(
      {this.oId,
        this.area,
        this.flat,
        this.address,
        this.userid,
        this.longitude,
        this.latitude,
        this.city,
        this.pincode,
        this.state,
        this.plan_year,
        this.model,
        this.paymentId,
        this.payment_amount,
        this.appointmentDate,
        this.orderingDate,
        this.Status,
        this.gst,
        this.billingaddress,
        this.companyname,
        this.remainingBalance,
        this.deposite,
        this.monthlyPayment_amount,
        this.quantity,
        required OrderDetails addressDetails});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    oId = json['_id'];
    area = json['area'];
    flat = json['flat'];
    address = json['address'];
    userid = json['userid'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
    plan_year = json['plan_year'];
    model = json['model'];
    paymentId = json['paymentId'];
    payment_amount = json['payment_amount'];
    appointmentDate = json['appointmentDate'];
    orderingDate = json['orderingDate'];
    Status = json['Status'];
    gst = json['gst'];
    companyname = json['companyname'];
    billingaddress = json['billingaddress'];
    remainingBalance = json['remainingBalance'];
    monthlyPayment_amount = json['monthlyPayment_amount'];
    deposite = json['deposite'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = oId;
    data['area'] = area;
    data['flat'] = flat;
    data['address'] = address;
    data['userid'] = userid;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['city'] = city;
    data['pincode'] = pincode;
    data['state'] = state;
    data['plan_year'] = plan_year;
    data['model'] = model;
    data['paymentId'] = paymentId;
    data['payment_amount'] = payment_amount;
    data['appointmentDate'] = appointmentDate;
    data['orderingDate'] = orderingDate;
    data['Status'] = Status;
    data['gst'] = gst;
    data['companyname'] = companyname;
    data['billingaddress'] = billingaddress;
    data['remainingBalance'] = remainingBalance;
    data['monthlyPayment_amount'] = monthlyPayment_amount;
    data['deposite'] = deposite;
    data['quantity'] = quantity;
    return data;
  }
}
