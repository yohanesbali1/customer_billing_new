part of "models.dart";

class Subdistrict {
  final int id;
  final String code;
  final String name;

  Subdistrict({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Subdistrict.fromJson(Map<String, dynamic> json) {
    return Subdistrict(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}
