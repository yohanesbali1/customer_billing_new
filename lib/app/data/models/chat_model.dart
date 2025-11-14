part of "models.dart";

class ChatModel {
  final String date;
  final List<Chat> chat;

  ChatModel({required this.date, required this.chat});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
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

class ChatResponseModel {
  final List<ChatModel> data;
  final MetaData? meta;

  ChatResponseModel({required this.data, this.meta});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ChatModel.fromJson(e))
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
