part of "models.dart";

class MetaData {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;
  final int? total_unread;

  MetaData({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
    this.total_unread,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'] is String
          ? int.tryParse(json['per_page'])
          : json['per_page'],
      to: json['to'],
      total: json['total'],
      total_unread: json['total_unread'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'per_page': perPage,
      'to': to,
      'total': total,
      'total_unread': total_unread,
    };
  }
}
