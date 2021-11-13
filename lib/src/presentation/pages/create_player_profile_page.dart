import 'package:esporty/src/constants/games.dart';
import 'package:esporty/src/data/models/game_model.dart';
import 'package:esporty/src/logic/cubits/game_cubit/game_cubit.dart';
import 'package:esporty/src/logic/cubits/image_util_cubit/image_util_cubit.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/presentation/components/game_list.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/bnr.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/image_selector.dart';
import 'package:esporty/src/presentation/widgets/tf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreatePlayerProfilePage extends StatefulWidget {
  const CreatePlayerProfilePage({Key? key}) : super(key: key);

  @override
  State<CreatePlayerProfilePage> createState() =>
      _CreatePlayerProfilePageState();
}

class _CreatePlayerProfilePageState extends State<CreatePlayerProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String _imageUrl;
  late Map<String, String> _gameData;

  Map<String, dynamic> get getCurrentStateValues {
    if (_formKey.currentState == null) {
      return {'Enter Name': null};
    }
    _formKey.currentState!.save();
    return _formKey.currentState!.value;
  }

  onSubmitPressed(context, imageUrl) => getCurrentStateValues
              .containsKey(null) ||
          getCurrentStateValues.containsValue(null) ||
          getCurrentStateValues['Enter Name'].isEmpty ||
          imageUrl.isEmpty ||
          _gameData.isEmpty
      ? null
      : () async {
          final data = getCurrentStateValues;

          BlocProvider.of<PlayerCubit>(context).setPlayerProfileImg(imageUrl);
          BlocProvider.of<PlayerCubit>(context)
              .setPlayerName(data['Enter Name']);

          for (String gameName in _gameData.keys) {
            BlocProvider.of<GameCubit>(context).addGame(
              GameModel(
                gameName: gameName,
                gamePlayerId: _gameData[gameName]!,
              ),
            );
          }

          final result = await BlocProvider.of<PlayerCubit>(context)
              .isPlayerProfileCompleted();
          if (result == true) {
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.of(context).pushReplacementNamed(Routes.bottomNavigator);
          } else {
            bnr(context, 'failed to complete profile!! Try again.');
          }
        };

  @override
  void initState() {
    super.initState();
    _imageUrl = '';
    _gameData = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          children: [
            ImageSelector(onPressed: () {
              BlocProvider.of<ImageUtilCubit>(context).uploadPlayerProfileImg();
            }),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: const [
                  SizedBox(height: 30),
                  TF(
                    label: 'Enter Name',
                    isPassword: false,
                  ),
                ],
              ),
              onChanged: () {
                setState(() {});
              },
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GameList(
                gameList: games.keys.toList(),
                gameData: _gameData,
                notifyParent: (value) {
                  setState(() {
                    _gameData = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            BlocListener<ImageUtilCubit, ImageUtilState>(
              listener: (context, imageState) {
                if (imageState is ImagePlayerProfileImgUploadSucceed) {
                  setState(() {
                    _imageUrl = imageState.imageUrl;
                  });
                } else {
                  setState(() {
                    _imageUrl = '';
                  });
                }
              },
              child: ElevatedBtn(
                label: 'Submit',
                onPressed: onSubmitPressed(context, _imageUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
