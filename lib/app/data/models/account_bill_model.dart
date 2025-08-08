part of "models.dart";

class AccountBillModel {
  final int id;
  final int customerId;
  final List<Order> orders;
  final dynamic startDate;
  final dynamic endDate;
  final String service;
  final dynamic approveAt;
  final int price;
  final String status;
  final String paymentCode;
  final ProfileModel customer;
  final String registrationDate;

  AccountBillModel({
    required this.id,
    required this.customerId,
    required this.orders,
    required this.startDate,
    required this.endDate,
    required this.service,
    this.approveAt,
    required this.price,
    required this.status,
    required this.paymentCode,
    required this.registrationDate,
    required this.customer,
  });

  factory AccountBillModel.fromJson(Map<String, dynamic> json) {
    var orderList =
        (json['order'] as List).map((order) => Order.fromJson(order)).toList();

    return AccountBillModel(
      id: json['id'],
      customerId: json['customer_id'],
      orders: orderList,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      service: json['service'],
      approveAt: json['approve_at'],
      price: json['price'],
      status: json['status'],
      paymentCode: json['payment_code'],
      registrationDate: json['registration_date'],
      customer: ProfileModel.fromJson(json['customer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'order': orders.map((order) => order.toJson()).toList(),
      'start_date': startDate,
      'end_date': endDate,
      'service': service,
      'approve_at': approveAt,
      'price': price,
      'status': status,
      'payment_code': paymentCode,
      'registration_date': registrationDate,
      'customer': customer.toJson(),
    };
  }
}
