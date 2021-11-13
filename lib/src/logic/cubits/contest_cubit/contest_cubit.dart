import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/data/models/contest_model.dart';
import 'package:esporty/src/data/repositories/contest_repository.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'contest_state.dart';

class ContestCubit extends Cubit<ContestState> with HydratedMixin {
  final ContestRepository contestRepository;
  final AuthenticationCubit authenticationCubit;
  ContestCubit({
    required this.contestRepository,
    required this.authenticationCubit,
  }) : super(ContestLoading()) {
    monitorContestListener();
  }

  Future<void> createContest(Map<String, dynamic> contestDetail,
      String _contestType, String squadId) async {
    await contestRepository.createContest(contestDetail, _contestType, squadId);
  }

  monitorContestListener() {
    authenticationCubit.stream.listen((event) {
      if (event is AuthenticationLoading) {
        emitContestLoading();
      } else if (event is AuthenticationSucceed) {
        if (event.authenticationSucceedType ==
            AuthenticationSucceedType.notVerified) {
        } else {
          startContestListener();
        }
      } else {
        emitContesFailed();
      }
    });
  }

  startContestListener() async {
    contestRepository.contestListener().listen((event) {
      emitContestLoading();
      try {
        if (event.snapshot.exists && event.snapshot.value != null) {
          final contestsKey = event.snapshot.value.keys.toList();
          List<ContestModel> listContestModel = [];

          for (dynamic key in contestsKey) {
            final model = ContestModel.fromMap(event.snapshot.value[key]);
            model.contestId = key;
            listContestModel.add(model);
          }
          emitContesSucceed(listContestModel);
        } else {
          emitContesFailed();
        }
      } catch (e) {
        emitContesFailed();
      }
    });
  }

  emitContestLoading() => emit(ContestLoading());
  emitContesSucceed(_listContestModel) =>
      emit(ContestSucceed(listContestModel: _listContestModel));
  emitContesFailed() => emit(ContestFailed());

  @override
  ContestState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return ContestSucceed.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ContestState state) {
    if (state is ContestSucceed) return state.toMap();
  }
}
