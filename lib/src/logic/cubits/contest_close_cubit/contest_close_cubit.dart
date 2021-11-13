import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/data/models/contest_close_model.dart';
import 'package:esporty/src/data/repositories/contest_close_repository.dart';
import 'package:meta/meta.dart';

part 'contest_close_state.dart';

class ContestCloseCubit extends Cubit<ContestCloseState> {
  final ContestCloseRepository contestCloseRepository;
  late StreamSubscription contestCloseSubscription;
  ContestCloseCubit({required this.contestCloseRepository})
      : super(ContestCloseLoading());

  Future<void> acceptCloseContest(String contestId, String squadId) async {
    return contestCloseRepository.addContestAccepted(contestId, squadId);
  }

  void startContestCloseStream(String contestId) {
    contestCloseSubscription =
        contestCloseRepository.contestCloseListener(contestId).listen((event) {
      emitContestCloseLoading();
      try {
        if (event.snapshot.exists && event.snapshot.value != null) {
          final model = ContestCloseModel.fromMap(event.snapshot.value);
          emitContestCloseSucceed(model);
        } else {
          emitContestCloseFailed();
        }
      } catch (e) {
        emitContestCloseFailed();
      }
    });
  }

  emitContestCloseLoading() => emit(ContestCloseLoading());
  emitContestCloseSucceed(_contestCloseModel) =>
      emit(ContestCloseSucceed(contestCloseModel: _contestCloseModel));
  emitContestCloseFailed() => emit(ContestCloseFailed());

  closeStream() {
    try {
      contestCloseSubscription.cancel();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    closeStream();
    return super.close();
  }
}
