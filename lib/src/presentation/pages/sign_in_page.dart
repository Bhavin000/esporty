import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/bnr.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/icon_elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:esporty/src/presentation/widgets/tf.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  SignInPage({Key? key}) : super(key: key);

  onLoginPressed(BuildContext context) {
    _formKey.currentState!.save();
    final data = _formKey.currentState!.value;

    if (data.containsKey(null) ||
        data.containsValue(null) ||
        data['email'].isEmpty ||
        data['password'].isEmpty) {
      bnr(context, 'enter all details');
    } else {
      BlocProvider.of<AuthenticationCubit>(context).emailSignIn(
        data['email'],
        data['password'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) async {
          if (state is AuthenticationSucceed) {
            if (state.authenticationSucceedType ==
                AuthenticationSucceedType.notVerified) {
            } else {
              // BlocProvider.of<GameCardCubit>(context).getGameCards();

              final result = await BlocProvider.of<PlayerCubit>(context)
                  .isPlayerProfileCompleted();

              if (result == true) {
                await Future.delayed(const Duration(milliseconds: 500));
                Navigator.of(context)
                    .pushReplacementNamed(Routes.bottomNavigator);
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.createPlayerProfilePage);
              }
            }
          } else if (state is AuthenticationFailed) {
            bnr(context, 'login failed!!!');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // email-password form
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: const [
                    TF(label: 'email', isPassword: false),
                    SizedBox(height: 12),
                    TF(label: 'password', isPassword: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // login
              ElevatedBtn(
                label: 'Login',
                onPressed: () => onLoginPressed(context),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextBtn(
                    text: 'CREATE ACCOUNT',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.signUpPage);
                    },
                  ),
                  const Text('|'),
                  TextBtn(
                    text: 'FORGET PASSWORD',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // google sign in
              IconElevatedlBtn(
                icon: EvaIcons.google,
                label: 'Continue with google',
                onPressed: () {
                  BlocProvider.of<AuthenticationCubit>(context).googleSignIn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
