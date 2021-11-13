part of 'contest_cubit.dart';

abstract class ContestState extends Equatable {
  const ContestState();

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() => {};
}

class ContestLoading extends ContestState {}

class ContestSucceed extends ContestState {
  final List<ContestModel> listContestModel;
  const ContestSucceed({required this.listContestModel});

  @override
  List<Object> get props => [listContestModel];

  @override
  Map<String, dynamic> toMap() {
    return {
      'listContestModel': listContestModel.map((x) => x.toMap()).toList(),
    };
  }

  factory ContestSucceed.fromMap(Map<String, dynamic> map) {
    return ContestSucceed(
      listContestModel: List<ContestModel>.from(
          map['listContestModel']?.map((x) => ContestModel.fromMap(x))),
    );
  }
}

class ContestFailed extends ContestState {}
