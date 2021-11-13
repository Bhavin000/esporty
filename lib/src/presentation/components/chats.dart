import 'package:dash_chat/dash_chat.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats extends StatelessWidget {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, chatState) {
          if (chatState is ChatLoading) {
            return const LinearProgressIndicator();
          } else if (chatState is ChatSucceed) {
            final data = chatState.listChatModel;
            return DashChat(
              key: _chatViewKey,
              messages: data.isEmpty
                  ? []
                  : data
                      .map((value) => chatMessage(
                          value.message, chatUser(value.chatCreatedBy)))
                      .toList(),
              onSend: (value) {
                if (value.text!.isNotEmpty) {
                  BlocProvider.of<ChatCubit>(context).addChatData(value.text!);
                }
              },
              user: chatUser(BlocProvider.of<AuthenticationCubit>(context)
                  .authenticationRepository
                  .getCurrentUserId),
              avatarMaxSize: 0,
              avatarBuilder: null,
              inputDecoration: InputDecoration(
                fillColor: Theme.of(context).cardTheme.color,
                filled: true,
                border: InputBorder.none,
              ),
              inputContainerStyle: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
              ),
              inputTextStyle: Theme.of(context).textTheme.bodyText1,
            );
          }
          return DashChat(
            key: _chatViewKey,
            messages: const [],
            onSend: (value) {
              if (value.text!.isNotEmpty) {
                BlocProvider.of<ChatCubit>(context).addChatData(value.text!);
              }
            },
            user: chatUser(BlocProvider.of<AuthenticationCubit>(context)
                .authenticationRepository
                .getCurrentUserId),
            avatarMaxSize: 0,
            avatarBuilder: null,
          );
        },
      ),
    );
  }

  ChatMessage chatMessage(String _text, ChatUser _chatUser) {
    return ChatMessage(
      text: _text,
      user: _chatUser,
      createdAt: null,
    );
  }

  ChatUser chatUser(String _userId) {
    return ChatUser(
      uid: _userId,
    );
  }
}
