part of "models.dart";

class DashboardModel {
  final int total_unread;

  DashboardModel({required this.total_unread});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(total_unread: json['total_unread']);
  }

  Map<String, dynamic> toJson() {
    return {'total_unread': total_unread};
  }
}
