import 'package:esporty/src/data/models/player_model.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/presentation/components/player_profile_drawer.dart';
import 'package:esporty/src/presentation/navigator/navigator_defination.dart';
import 'package:esporty/src/presentation/navigator/screens/contest_screen.dart';
import 'package:esporty/src/presentation/navigator/screens/instant_game_screen.dart';
import 'package:esporty/src/presentation/navigator/screens/message_screen.dart';
import 'package:esporty/src/presentation/navigator/screens/squad_screen.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigator extends StatefulWidget {
  List<Widget> bottomNavigatorScreens(PlayerModel playerModel) => [
        ContestScreen(squadId: playerModel.playerSquadJoined!),
        const SquadScreen(),
        MessageScreen(squadId: playerModel.playerSquadJoined!),
        const InstantGameScreen(),
      ];
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late int _idx;
  late PlayerModel playerModel;

  @override
  void initState() {
    super.initState();
    _idx = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthenticationFailed) {
          Navigator.of(context).popAndPushNamed(Routes.signInPage);
        }
      },
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, playerState) {
          if (playerState is PlayerSucceed) {
            return Scaffold(
              appBar: AppBar(
                title: NavDef.appBarData(context, playerState.playerModel)[_idx]
                    ['title'],
                actions:
                    NavDef.appBarData(context, playerState.playerModel)[_idx]
                        ['actions'],
              ),
              body:
                  widget.bottomNavigatorScreens(playerState.playerModel)[_idx],
              bottomNavigationBar: BottomNavigationBar(
                items: NavDef.screensData
                    .map(
                      (data) => BottomNavigationBarItem(
                        activeIcon: Icon(data['activeIcon']),
                        icon: Icon(data['icon']),
                        label: '',
                        tooltip: data['label'],
                      ),
                    )
                    .toList(),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                currentIndex: _idx,
                onTap: (value) {
                  setState(() {
                    _idx = value;
                  });
                },
              ),
              drawer: const PlayerProfileDrawer(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
