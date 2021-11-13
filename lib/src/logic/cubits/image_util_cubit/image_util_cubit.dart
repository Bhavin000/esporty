import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/data/repositories/util_repository.dart';

part 'image_util_state.dart';

class ImageUtilCubit extends Cubit<ImageUtilState> {
  final UtilRepository utilsRepository;
  ImageUtilCubit({
    required this.utilsRepository,
  }) : super(ImageUtilLoading());

  void uploadPlayerProfileImg() {
    emitImageUtilLoading();
    utilsRepository
        .setPlayerProfileImg()
        .then((value) => emitImagePlayerProfileImgUploadSucceed(value))
        .onError((error, stackTrace) {
      emitImageUtilFailed();
    });
  }

  void uploadSquadProfileImg() {
    emitImageUtilLoading();
    utilsRepository
        .setSquadProfileImg()
        .then((value) => emitSquadPlayerProfileImgUploadSucceed(value))
        .onError((error, stackTrace) {
      emitImageUtilFailed();
    });
  }

  emitImageUtilLoading() => emit(ImageUtilLoading());
  emitImagePlayerProfileImgUploadSucceed(String _imageUrl) =>
      emit(ImagePlayerProfileImgUploadSucceed(imageUrl: _imageUrl));
  emitSquadPlayerProfileImgUploadSucceed(String _imageUrl) =>
      emit(ImageSquadProfileImgUploadSucceed(imageUrl: _imageUrl));
  emitImageUtilFailed() => emit(ImageUtilFailed());
}
