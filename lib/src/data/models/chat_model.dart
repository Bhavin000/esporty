import 'dart:convert';

class ChatModel {
  String chatCreatedBy;
  String message;
  ChatModel({
    required this.chatCreatedBy,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatCreatedBy': chatCreatedBy,
      'message': message,
    };
  }

  factory ChatModel.fromMap(map) {
    return ChatModel(
      chatCreatedBy: map['chatCreatedBy'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.chatCreatedBy == chatCreatedBy &&
        other.message == message;
  }

  @override
  int get hashCode => chatCreatedBy.hashCode ^ message.hashCode;
}
