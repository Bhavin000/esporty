import 'package:esporty/src/data/repositories/authentication_repository.dart';
import 'package:esporty/src/data/repositories/chat_repository.dart';
import 'package:esporty/src/data/repositories/contest_close_repository.dart';
import 'package:esporty/src/data/repositories/contest_repository.dart';
import 'package:esporty/src/data/repositories/game_repository.dart';
import 'package:esporty/src/data/repositories/player_repository.dart';
import 'package:esporty/src/data/repositories/room_repository.dart';
import 'package:esporty/src/data/repositories/squad_repository.dart';
import 'package:esporty/src/data/repositories/util_repository.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:esporty/src/logic/cubits/contest_close_cubit/contest_close_cubit.dart';
import 'package:esporty/src/logic/cubits/contest_cubit/contest_cubit.dart';
import 'package:esporty/src/logic/cubits/game_cubit/game_cubit.dart';
import 'package:esporty/src/logic/cubits/image_util_cubit/image_util_cubit.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/logic/cubits/room_cubit/room_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:esporty/src/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AppRoutes appRoutes;
  final AuthenticationRepository authenticationRepository;
  final UtilRepository utilRepository;
  final PlayerRepository playerRepository;
  final GameRepository gameRepository;
  final SquadRepository squadRepository;
  final ChatRepository chatRepository;
  final ContestRepository contestRepository;
  final RoomRepositoty roomRepositoty;
  final ContestCloseRepository contestCloseRepository;

  const App({
    Key? key,
    required this.appRoutes,
    required this.authenticationRepository,
    required this.utilRepository,
    required this.playerRepository,
    required this.gameRepository,
    required this.squadRepository,
    required this.chatRepository,
    required this.contestRepository,
    required this.roomRepositoty,
    required this.contestCloseRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
              authenticationRepository: authenticationRepository),
          lazy: false,
        ),
        BlocProvider<ImageUtilCubit>(
          create: (context) => ImageUtilCubit(utilsRepository: utilRepository),
        ),
        BlocProvider<GameCubit>(
          create: (context) => GameCubit(gameRepository: gameRepository),
        ),
        BlocProvider<PlayerCubit>(
          create: (context) => PlayerCubit(
            playerRepository: playerRepository,
            authenticationCubit: BlocProvider.of<AuthenticationCubit>(context),
            gameCubit: BlocProvider.of<GameCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<SquadCubit>(
          create: (context) => SquadCubit(
            squadRepository: squadRepository,
            playerCubit: BlocProvider.of<PlayerCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(
            chatRepository: chatRepository,
            playerCubit: BlocProvider.of<PlayerCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<ContestCubit>(
          create: (context) => ContestCubit(
            contestRepository: contestRepository,
            authenticationCubit: BlocProvider.of<AuthenticationCubit>(context),
          ),
          lazy: false,
        ),
        BlocProvider<RoomCubit>(
          create: (context) => RoomCubit(
            roomRepositoty: roomRepositoty,
          ),
        ),
        BlocProvider<ContestCloseCubit>(
          create: (context) =>
              ContestCloseCubit(contestCloseRepository: contestCloseRepository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'eSporty',
            theme: themeState.appTheme.themeData,
            onGenerateRoute: appRoutes.onGeneratedRoutes,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
