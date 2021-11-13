part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatSucceed extends ChatState {
  final List<dynamic> listChatModel;
  const ChatSucceed({required this.listChatModel});

  @override
  List<Object> get props => [listChatModel];

  Map<String, dynamic> toMap() {
    return {
      'listChatModel': listChatModel,
    };
  }

  factory ChatSucceed.fromMap(Map<String, dynamic> map) {
    return ChatSucceed(
      listChatModel: List<dynamic>.from(map['listChatModel']),
    );
  }
}

class ChatFailed extends ChatState {}
