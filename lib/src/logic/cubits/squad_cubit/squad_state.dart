part of 'squad_cubit.dart';

abstract class SquadState extends Equatable {
  const SquadState();

  @override
  List<Object> get props => [];
}

class SquadLoading extends SquadState {}

class SquadSucceed extends SquadState {
  final SquadModel squadModel;
  const SquadSucceed({required this.squadModel});
}

class SquadFailed extends SquadState {}
