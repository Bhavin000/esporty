part of 'room_cubit.dart';

@immutable
abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RoomLoading extends RoomState {}

class RoomSucceed extends RoomState {
  final RoomModel roomModel;
  RoomSucceed({required this.roomModel});
}

class RoomFailed extends RoomState {}
