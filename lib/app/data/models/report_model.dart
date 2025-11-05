part of "models.dart";

class ReportModel {
  final int id;
  final TypeTopic typeTopic;
  final dynamic createdAt;
  final Status status;

  ReportModel({
    required this.id,
    required this.typeTopic,
    required this.createdAt,
    required this.status,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
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

class ReportModelDetail {
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

  ReportModelDetail({
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

  factory ReportModelDetail.fromJson(Map<String, dynamic> json) {
    return ReportModelDetail(
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

class ChatResponse {
  final String date;
  final List<Chat> chat;

  ChatResponse({required this.date, required this.chat});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      date: json['date'],
      chat: List<Chat>.from(json['chat'].map((x) => Chat.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'chat': chat.map((x) => x.toJson()).toList()};
  }
}

class Chat {
  final int id;
  final int topicChatId;
  final int senderId;
  final String? message;
  final bool me;
  final bool is_image;
  final DateTime createdAt;
  final String? file;

  Chat({
    required this.id,
    required this.topicChatId,
    required this.senderId,
    this.message,
    this.file,
    required this.me,
    required this.is_image,
    required this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      topicChatId: json['topic_chat_id'],
      senderId: json['sender_id'],
      message: json['message'],
      file: json['file'],
      me: json['me'],
      is_image: json['is_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic_chat_id': topicChatId,
      'sender_id': senderId,
      'message': message,
      'file': file,
      'is_image': is_image,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ReportResponseModel {
  final List<ReportModel> data;
  final MetaData? meta;

  ReportResponseModel({required this.data, this.meta});

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    return ReportResponseModel(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ReportModel.fromJson(e))
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
