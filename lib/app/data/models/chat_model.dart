part of "models.dart";

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
