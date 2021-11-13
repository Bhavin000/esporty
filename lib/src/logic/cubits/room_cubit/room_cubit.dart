import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/data/models/room_model.dart';
import 'package:esporty/src/data/repositories/room_repository.dart';
import 'package:meta/meta.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepositoty roomRepositoty;
  RoomCubit({required this.roomRepositoty}) : super(RoomLoading());

  Future<RoomModel> getRoomDetails(String roomId) async {
    return roomRepositoty.getRoomDetails(roomId);
  }
}
