part of "models.dart";

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final String? type_id;
  final String? link;
  final bool is_read;
  final DateTime createdAt;

  NotificationModel({
    this.type_id,
    this.link,
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.is_read,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      type_id: json['type_id'],
      link: json['link'],
      is_read: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'type': type,
    'type_id': type_id,
    'link': link,
    'is_read': is_read,
    'created_at': createdAt,
  };
}

class NotificationResponseModel {
  final List<NotificationModel> data;
  final MetaData? meta;

  NotificationResponseModel({required this.data, this.meta});

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => NotificationModel.fromJson(e))
              .toList() ??
          [],
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}
