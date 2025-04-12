class SwipeCustomerModel {
  String? customerId;
  String? name;
  String? phone;
  String? email;
  String? gstin;
  String? swipeId;

  SwipeCustomerModel(
      {this.customerId,
        this.name,
        this.phone,
        this.email,
        this.gstin,
        this.swipeId});

  SwipeCustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    gstin = json['gstin'];
    swipeId = json['swipe_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gstin'] = this.gstin;
    data['swipe_id'] = this.swipeId;
    return data;
  }
}