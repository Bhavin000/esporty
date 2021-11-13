import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/data/models/squad_model.dart';
import 'package:esporty/src/data/repositories/squad_repository.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';

part 'squad_state.dart';

class SquadCubit extends Cubit<SquadState> {
  final SquadRepository squadRepository;
  final PlayerCubit playerCubit;
  SquadCubit({
    required this.squadRepository,
    required this.playerCubit,
  }) : super(SquadLoading()) {
    monitorSquadListener();
  }

  createSquad(String squadName, String imageUrl, String gameName) {
    squadRepository.createSquad(squadName, imageUrl, gameName);
  }

  Future<bool> isSquadDetailsCompleted() async {
    try {
      await squadRepository.isSquadDetailsCompleted();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> applyToContest(String contestId, String squadId) async {
    return squadRepository.addSquadAppliedContest(contestId, squadId);
  }

  Future<void> acceptPlayerRequest(String squadId, String playerId) {
    return squadRepository.acceptPlayerJoined(squadId, playerId);
  }

  Future<SquadModel> getSquadDetails(String squadId) async {
    return squadRepository.getSquadDetails(squadId);
  }

  Future<List<SquadModel>> getAllSquads() async {
    return squadRepository.getAllSquads();
  }

  monitorSquadListener() {
    playerCubit.stream.listen((event) {
      if (event is PlayerLoading) {
        emitSquadLoading();
      } else if (event is PlayerSucceed) {
        if (event.playerModel.playerSquadJoined!.isNotEmpty) {
          startSquadListener(event.playerModel.playerSquadJoined!);
        }
      } else {
        emitSquadFailed();
      }
    });
  }

  startSquadListener(String squadId) async {
    squadRepository.squadListener(squadId).listen((event) {
      emitSquadLoading();
      try {
        if (event.snapshot.exists && event.snapshot.value != null) {
          emitSquadSucceed(SquadModel.fromMap(event.snapshot.value));
        } else {
          emitSquadFailed();
        }
      } catch (e) {
        emitSquadFailed();
      }
    });
  }

  emitSquadLoading() => emit(SquadLoading());
  emitSquadSucceed(_squadModel) => emit(SquadSucceed(squadModel: _squadModel));
  emitSquadFailed() => emit(SquadFailed());
}
