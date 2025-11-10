part of "models.dart";

class HelpModel {
  final int id;
  final TypeTopic typeTopic;
  final dynamic createdAt;
  final Status status;

  HelpModel({
    required this.id,
    required this.typeTopic,
    required this.createdAt,
    required this.status,
  });

  factory HelpModel.fromJson(Map<String, dynamic> json) {
    return HelpModel(
      id: json['id'],
      typeTopic: TypeTopic.fromJson(json['type_topic']),
      createdAt: DateTime.parse(json['created_at']),
      status: Status.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type_topic': typeTopic.toJson(),
    'created_at': createdAt,
    'status': status.toJson(),
  };
}

class HelpModelDetail {
  final int id;
  final TypeTopic typeTopic;
  final dynamic num_topic;
  final String description;
  final String address;
  final String maps;
  final String phone;
  final String img;
  final dynamic createdAt;
  final List<Status> status;

  HelpModelDetail({
    required this.id,
    required this.typeTopic,
    required this.num_topic,
    required this.description,
    required this.address,
    required this.maps,
    required this.phone,
    required this.createdAt,
    required this.status,
    required this.img,
  });

  factory HelpModelDetail.fromJson(Map<String, dynamic> json) {
    return HelpModelDetail(
      id: json['id'],
      typeTopic: TypeTopic.fromJson(json['type_topic']),
      num_topic: json['num_topic'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      maps: json['maps'],
      img: json['img'],
      createdAt: DateTime.parse(json['created_at']),
      status: List<Status>.from(json['status'].map((x) => Status.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type_topic': typeTopic.toJson(),
    'num_topic': num_topic,
    'description': description,
    'address': address,
    'phone': phone,
    'maps': maps,
    'img': img,
    'created_at': createdAt,
    'status': status.map((x) => x.toJson()).toList(),
  };
}

class TypeTopic {
  final int id;
  final String type;

  TypeTopic({required this.id, required this.type});

  factory TypeTopic.fromJson(Map<String, dynamic> json) {
    return TypeTopic(id: json['id'], type: json['type']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'type': type};
}

class Status {
  final String status;
  final String description;
  final DateTime time;
  final UserApprove? userApprove;

  Status({
    required this.status,
    required this.description,
    required this.time,
    this.userApprove,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      status: json['status'],
      description: json['description'],
      time: DateTime.parse(json['time']),
      userApprove: json['user_approve'] != null
          ? UserApprove.fromJson(json['user_approve'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'description': description,
    'time': time.toIso8601String(),
    'userApprove': userApprove,
  };
}

class UserApprove {
  final String username;
  final String name;

  UserApprove({required this.username, required this.name});

  factory UserApprove.fromJson(Map<String, dynamic> json) {
    return UserApprove(username: json['username'], name: json['name']);
  }
}

class HelpResponseModel {
  final List<HelpModel> data;
  final MetaData? meta;

  HelpResponseModel({required this.data, this.meta});

  factory HelpResponseModel.fromJson(Map<String, dynamic> json) {
    return HelpResponseModel(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => HelpModel.fromJson(e))
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
