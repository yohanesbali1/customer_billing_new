part of "models.dart";

class ProfileModel {
  final dynamic id;
  final dynamic code;
  final String name;
  final dynamic phone;
  final dynamic address;
  final dynamic nik;
  final dynamic ktp;
  final String email;
  final SubCompany subCompany;
  final Province? province;
  final City? city;
  final Subdistrict? subdistrict;
  final String? vilage;

  ProfileModel(
      {required this.id,
      required this.code,
      required this.name,
      required this.phone,
      required this.address,
      required this.nik,
      required this.ktp,
      required this.subCompany,
      required this.email,
      this.province,
      this.city,
      this.subdistrict,
      this.vilage});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'] ?? "",
        code: json['code'] ?? "",
        name: json['name'] ?? "",
        phone: json['phone'] ?? "",
        address: json['address'] ?? "",
        nik: json['nik'] ?? "",
        ktp: json['ktp'],
        email: json['email'],
        vilage: json['desa'] ?? "",
        subCompany: SubCompany.fromJson(json['sub_company']),
        province: json['provinsi'] != null
            ? Province.fromJson(json['provinsi'])
            : null,
        city:
            json['kabupaten'] != null ? City.fromJson(json['kabupaten']) : null,
        subdistrict: json['kecamatan'] != null
            ? Subdistrict.fromJson(json['kecamatan'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'phone': phone,
      'address': address,
      'nik': nik,
      'email': email,
      'ktp': ktp,
      'subCompany': subCompany.toJson(),
      'province': province?.toJson() ?? null,
      'city': city?.toJson() ?? null,
      'subdistrict': subdistrict?.toJson() ?? null,
      'vilage': vilage ?? null
    };
  }
}

class SubCompany {
  final int id;
  final int companyId;
  final String name;
  final String group;
  final String code;
  final String address;
  final String pic;

  SubCompany({
    required this.id,
    required this.companyId,
    required this.name,
    required this.group,
    required this.code,
    required this.address,
    required this.pic,
  });

  // Factory method to create a SubCompany instance from JSON
  factory SubCompany.fromJson(Map<String, dynamic> json) {
    return SubCompany(
      id: json['id'] as int,
      companyId: json['company_id'] as int,
      name: json['name'] as String,
      group: json['group'] as String,
      code: json['code'] as String,
      address: json['address'] as String,
      pic: json['pic'] as String,
    );
  }

  // Method to convert SubCompany instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'group': group,
      'code': code,
      'address': address,
      'pic': pic,
    };
  }
}
