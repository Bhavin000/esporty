part of 'image_util_cubit.dart';

abstract class ImageUtilState extends Equatable {
  const ImageUtilState();

  @override
  List<Object> get props => [];
}

class ImageUtilLoading extends ImageUtilState {}

class ImagePlayerProfileImgUploadSucceed extends ImageUtilState {
  final String imageUrl;
  const ImagePlayerProfileImgUploadSucceed({
    required this.imageUrl,
  });

  @override
  List<Object> get props => [imageUrl];
}

class ImageSquadProfileImgUploadSucceed extends ImageUtilState {
  final String imageUrl;
  const ImageSquadProfileImgUploadSucceed({
    required this.imageUrl,
  });

  @override
  List<Object> get props => [imageUrl];
}

class ImageUtilFailed extends ImageUtilState {}
