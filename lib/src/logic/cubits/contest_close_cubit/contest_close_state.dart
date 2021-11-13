part of 'contest_close_cubit.dart';

@immutable
abstract class ContestCloseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContestCloseLoading extends ContestCloseState {}

class ContestCloseSucceed extends ContestCloseState {
  final ContestCloseModel contestCloseModel;
  ContestCloseSucceed({required this.contestCloseModel});

  @override
  List<Object?> get props => [contestCloseModel];
}

class ContestCloseFailed extends ContestCloseState {}
