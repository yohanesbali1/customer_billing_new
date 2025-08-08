part of "models.dart";

class BankModel {
  final int id;
  final String name;
  final String uniq_name;
  final String? code;
  final String img;
  final String? guide;
  final double adminFee;

  BankModel(
      {required this.id,
      required this.name,
      required this.uniq_name,
      this.code,
      required this.img,
      required this.adminFee,
      this.guide});

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      name: json['name'],
      uniq_name: json['uniq_name'],
      code: json['code'],
      img: json['img'],
      adminFee: json['admin_fee'].toDouble(),
      guide: json['guide'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'uniq_name': uniq_name,
      'img': img,
      'guide': guide ?? "",
      'adminFee': adminFee,
    };
  }
}

class BankGroupModel {
  final String group;
  final List<BankModel> data;

  BankGroupModel({required this.group, required this.data});

  factory BankGroupModel.fromJson(Map<String, dynamic> json) {
    return BankGroupModel(
      group: json['group'],
      data: (json['data'] as List).map((e) => BankModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group': group,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
