import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/bnr.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:esporty/src/presentation/widgets/tf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  SignUpPage({Key? key}) : super(key: key);

  onSignupPressed(BuildContext context) {
    _formKey.currentState!.save();
    final data = _formKey.currentState!.value;

    if (data.containsKey(null) ||
        data.containsValue(null) ||
        data['email'].isEmpty ||
        data['password'].isEmpty ||
        data['confirm password'].isEmpty) {
      bnr(context, 'enter all details');
    } else {
      BlocProvider.of<AuthenticationCubit>(context).emailSignUp(
        data['email'],
        data['password'],
        data['confirm password'],
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
              await BlocProvider.of<AuthenticationCubit>(context).verifyEmail();
              Navigator.of(context).pushReplacementNamed(Routes.signInPage);
            }
          } else if (state is AuthenticationFailed) {
            bnr(context, 'signup failed!!!');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // email-password-confirm password form
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: const [
                    TF(label: 'email', isPassword: false),
                    SizedBox(height: 12),
                    TF(label: 'password', isPassword: true),
                    SizedBox(height: 12),
                    TF(label: 'confirm password', isPassword: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // sign up
              ElevatedBtn(
                label: 'Sign Up',
                onPressed: () => onSignupPressed(context),
              ),
              const SizedBox(height: 8),
              TextBtn(
                text: 'LOGIN',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signInPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
