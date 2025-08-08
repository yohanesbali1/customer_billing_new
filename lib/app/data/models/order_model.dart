part of "models.dart";

class Order {
  final int id;
  final int orderId;
  final int? packageId;
  final String productName;
  final double productPrice;
  final int ppn;
  final double price;
  final String? createdAt;
  final String? updatedAt;

  Order({
    required this.id,
    required this.orderId,
    required this.packageId,
    required this.productName,
    required this.productPrice,
    required this.ppn,
    required this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['order_id'],
      packageId: json['package_id'],
      productName: json['product_name'],
      productPrice: json['product_price'].toDouble(),
      ppn: json['ppn'],
      price: json['price'].toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'package_id': packageId,
      'product_name': productName,
      'product_price': productPrice,
      'ppn': ppn,
      'price': price,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
