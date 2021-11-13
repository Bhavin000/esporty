import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/logic/cubits/image_util_cubit/image_util_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageSelector extends StatelessWidget {
  final dynamic onPressed;
  const ImageSelector({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ClipOval(
        child: BlocBuilder<ImageUtilCubit, ImageUtilState>(
          builder: (context, state) {
            if (state is ImagePlayerProfileImgUploadSucceed) {
              return CachedNetworkImage(
                imageUrl: state.imageUrl,
                alignment: Alignment.center,
                placeholder: (context, url) =>
                    const ColoredBox(color: Colors.green),
                fit: BoxFit.cover,
              );
            } else if (state is ImageSquadProfileImgUploadSucceed) {
              return CachedNetworkImage(
                imageUrl: state.imageUrl,
                alignment: Alignment.center,
                placeholder: (context, url) =>
                    const ColoredBox(color: Colors.green),
                fit: BoxFit.cover,
              );
            }
            return MaterialButton(
              color: Colors.greenAccent,
              onPressed: onPressed,
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 28,
              ),
            );
          },
        ),
      ),
    );
  }
}
