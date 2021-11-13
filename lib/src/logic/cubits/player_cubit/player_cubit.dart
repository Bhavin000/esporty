import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/data/models/player_model.dart';
import 'package:esporty/src/data/repositories/player_repository.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/game_cubit/game_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> with HydratedMixin {
  final PlayerRepository playerRepository;
  final AuthenticationCubit authenticationCubit;
  final GameCubit gameCubit;
  PlayerCubit({
    required this.playerRepository,
    required this.authenticationCubit,
    required this.gameCubit,
  }) : super(PlayerLoading()) {
    monitorPlayerListener();
  }

  void setPlayerName(String playerName) {
    playerRepository.setPlayerName(playerName);
  }

  void setPlayerProfileImg(String playerProfileImg) {
    playerRepository.setPlayerProfileImg(playerProfileImg);
  }

  Future<bool> isPlayerProfileCompleted() async {
    try {
      await playerRepository.isPlayerProfileCompleted();
      return true;
    } catch (e) {
      return false;
    }
  }

  getCurrentPlayerId() {
    return playerRepository.getCurrentUserId;
  }

  Future<PlayerModel> getPlayerDetails(String playerId) async {
    return await playerRepository.getPlayerDetails(playerId);
  }

  requestToJoinSquad(String squadId) {
    playerRepository.requestSquadJoin(squadId);
  }

  monitorPlayerListener() {
    authenticationCubit.stream.listen((event) {
      if (event is AuthenticationLoading) {
        emitPlayerLoading();
      } else if (event is AuthenticationSucceed) {
        if (event.authenticationSucceedType ==
            AuthenticationSucceedType.notVerified) {
        } else {
          startPlayerListener();
        }
      } else {
        emitPlayerFailed();
      }
    });
  }

  startPlayerListener() async {
    playerRepository
        .playerListener(playerRepository.getCurrentUserId)
        .listen((event) {
      emitPlayerLoading();
      try {
        if (event.snapshot.exists && event.snapshot.value != null) {
          final result = PlayerModel.fromMap(event.snapshot.value);
          // TODO: check if connected to internet
          // if yes then run below code
          gameCubit.getGame(result.playerSelectedGames);
          emitPlayerSucceed(result);
        } else {
          emitPlayerFailed();
        }
      } catch (e) {
        emitPlayerFailed();
      }
    });
  }

  emitPlayerLoading() => emit(PlayerLoading());
  emitPlayerSucceed(PlayerModel _playerModel) =>
      emit(PlayerSucceed(playerModel: _playerModel));
  emitPlayerFailed() => emit(PlayerFailed());

  @override
  PlayerState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return PlayerSucceed.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(PlayerState state) {
    if (state is PlayerSucceed) return state.toMap();
  }
}
