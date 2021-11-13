import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AuthenticationSucceedType? authValue;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, authState) async {
            if (authState is AuthenticationSucceed) {
              authValue = authState.authenticationSucceedType;
            } else if (authState is AuthenticationFailed) {
              await Future.delayed(const Duration(milliseconds: 500));
              Navigator.of(context).pushReplacementNamed(Routes.signInPage);
            }
          },
        ),
        BlocListener<PlayerCubit, PlayerState>(
          listener: (context, playerState) {
            if (playerState is PlayerSucceed) {
              Navigator.pushReplacementNamed(context, Routes.bottomNavigator);
            } else if (playerState is PlayerFailed) {
              if (authValue != null &&
                  authValue == AuthenticationSucceedType.notVerified) {
                Navigator.of(context).pushReplacementNamed(Routes.signInPage);
              } else {
                Navigator.pushReplacementNamed(
                    context, Routes.createPlayerProfilePage);
              }
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: Text('eSporty'),
        ),
      ),
    );
  }
}
