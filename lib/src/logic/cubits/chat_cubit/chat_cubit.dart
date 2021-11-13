import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/data/models/chat_model.dart';
import 'package:esporty/src/data/repositories/chat_repository.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> with HydratedMixin {
  final ChatRepository chatRepository;
  final PlayerCubit playerCubit;
  ChatCubit({
    required this.chatRepository,
    required this.playerCubit,
  }) : super(ChatLoading()) {
    monitorChatListener();
  }

  addChatData(String chatData) async {
    await chatRepository.addChatData(chatData);
  }

  monitorChatListener() {
    playerCubit.stream.listen((event) {
      if (event is PlayerLoading) {
      } else if (event is PlayerSucceed) {
        if (event.playerModel.playerSquadJoined!.isNotEmpty) {
          startChatListener(event.playerModel.playerSquadJoined!);
        }
      } else {
        emitChatFailed();
      }
    });
  }

  startChatListener(String squadId) async {
    chatRepository.chatListener(squadId).listen((event) {
      emitChatLoading();
      try {
        if (event.snapshot.exists && event.snapshot.value != null) {
          final result = event.snapshot.value.values
              .toList()
              .map((data) => ChatModel.fromMap(data))
              .toList();
          emitChatSucceed(result);
        } else {
          emitChatFailed();
        }
      } catch (e) {
        emitChatFailed();
      }
    });
  }

  emitChatLoading() => emit(ChatLoading());
  emitChatSucceed(_listChatModel) =>
      emit(ChatSucceed(listChatModel: _listChatModel));
  emitChatFailed() => emit(ChatFailed());

  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return ChatSucceed.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ChatState state) {
    if (state is ChatSucceed) return state.toMap();
  }
}
