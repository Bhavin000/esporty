import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/game_cubit/game_cubit.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:esporty/src/presentation/themes/app_theme.dart';
import 'package:esporty/src/presentation/widgets/card_list_tile.dart';
import 'package:esporty/src/presentation/widgets/icon_btn.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerProfileDrawer extends StatelessWidget {
  const PlayerProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 18),
        child: BlocBuilder<PlayerCubit, PlayerState>(
          builder: (context, playerState) {
            if (playerState is PlayerSucceed) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Player Profile Image
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<SquadCubit, SquadState>(
                        builder: (context, squadState) {
                          if (squadState is SquadSucceed) {
                            return ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: squadState.squadModel.squadProfileImg,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const ColoredBox(color: Colors.red),
                                cacheKey: squadState.squadModel.squadProfileImg,
                                memCacheHeight: 80,
                                memCacheWidth: 80,
                                maxWidthDiskCache: 80,
                                maxHeightDiskCache: 80,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: playerState.playerModel.playerProfileImg,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const ColoredBox(color: Colors.red),
                          cacheKey: playerState.playerModel.playerProfileImg,
                          memCacheHeight: 80,
                          memCacheWidth: 80,
                          maxWidthDiskCache: 80,
                          maxHeightDiskCache: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // squad-name   player-name
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<SquadCubit, SquadState>(
                          builder: (context, squadState) {
                            if (squadState is SquadSucceed) {
                              return Text(
                                squadState.squadModel.squadName + ' ',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        Text(
                          playerState.playerModel.playerName,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // games list
                  Expanded(
                    child: BlocBuilder<GameCubit, GameState>(
                      builder: (context, gameState) {
                        print(gameState);
                        if (gameState is GameLoaded) {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: gameState.gameModels.length,
                            itemBuilder: (context, _index) => CardListTile(
                              title: gameState.gameModels[_index].gameName,
                              onPressed: () {},
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // theme changer
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, themeState) {
                          final _currentTheme = themeState.appTheme;
                          return IconBtn(
                            icon: _currentTheme is LightTheme
                                ? EvaIcons.bulbOutline
                                : EvaIcons.bulbOutline,
                            size: 32,
                            onPressed: () {
                              if (_currentTheme is LightTheme) {
                                BlocProvider.of<ThemeCubit>(context)
                                    .changeTheme(ThemeType.darkTheme);
                              } else {
                                BlocProvider.of<ThemeCubit>(context)
                                    .changeTheme(ThemeType.lightTheme);
                              }
                            },
                          );
                        },
                      ),
                      IconBtn(
                          icon: EvaIcons.logOutOutline,
                          size: 32,
                          onPressed: () {
                            BlocProvider.of<AuthenticationCubit>(context)
                                .signOut();
                          }),
                    ],
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
