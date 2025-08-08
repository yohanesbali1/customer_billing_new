part of "models.dart";

class InvoiceModel {
  final int id;
  final String numTransaction;
  final List<Order> order;
  final String customerName;
  final String phone;
  final String email;
  final String address;
  final double price;
  final String sales;
  final dynamic startDate;
  final dynamic endDate;
  final String status;
  final String? approveBy;
  final String? paymentMethod;
  final String? approveAt;
  final dynamic? paidAt;
  final String? payment_code;
  final dynamic createdAt;

  InvoiceModel({
    required this.id,
    required this.numTransaction,
    required this.order,
    required this.customerName,
    required this.phone,
    required this.email,
    required this.address,
    required this.price,
    required this.sales,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.approveBy,
    this.paymentMethod,
    this.approveAt,
    this.paidAt,
    this.payment_code,
    required this.createdAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      numTransaction: json['num_transaction'],
      order: (json['order'] as List<dynamic>)
          .map((order) => Order.fromJson(order))
          .toList(),
      customerName: json['customer_name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      price: double.parse(json['price']), //json['price'],
      sales: json['sales'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'],
      status: json['status'],
      approveBy: json['approve_by'],
      paymentMethod: json['payment_method'],
      approveAt: json['approve_at'],
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num_transaction': numTransaction,
      'order': order.map((o) => o.toJson()).toList(),
      'customer_name': customerName,
      'phone': phone,
      'email': email,
      'address': address,
      'price': price,
      'sales': sales,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'approve_by': approveBy,
      'payment_method': paymentMethod,
      'approve_at': approveAt,
      'paid_at': paidAt,
      'created_at': createdAt,
    };
  }
}
