import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/data/repositories/authentication_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState>
    with HydratedMixin {
  final AuthenticationRepository authenticationRepository;
  late StreamSubscription _authenticationSubscription;

  AuthenticationCubit({
    required this.authenticationRepository,
  }) : super(AuthenticationLoading()) {
    monitorAuthentication();
  }

  Future<void> emailSignIn(String email, String password) async {
    try {
      await authenticationRepository.emailSignIn(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> emailSignUp(
      String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return;
    }
    try {
      await authenticationRepository.emailSignup(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyEmail() async {
    try {
      await authenticationRepository.verifyEmail();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> googleSignIn() async {
    try {
      await authenticationRepository.googleSignIn();
    } catch (e) {
      rethrow;
    }
  }

  signOut() {
    try {
      authenticationRepository.signOut();
    } catch (e) {
      rethrow;
    }
  }

  void monitorAuthentication() {
    _authenticationSubscription =
        authenticationRepository.userChangesListener().listen((user) async {
      emitAuthenticationLoading();
      try {
        await user!.getIdToken();

        if (user.emailVerified == false) {
          emitAuthenticationSucceed(AuthenticationSucceedType.notVerified);
        } else if (user.providerData[0].providerId == 'password') {
          emitAuthenticationSucceed(AuthenticationSucceedType.email);
        } else if (user.providerData[0].providerId == 'google.com') {
          emitAuthenticationSucceed(AuthenticationSucceedType.google);
        }
      } catch (e) {
        emitAuthenticationFailed();
      }
    });
  }

  emitAuthenticationLoading() => emit(AuthenticationLoading());
  emitAuthenticationSucceed(
          AuthenticationSucceedType _authenticationSucceedType) =>
      emit(AuthenticationSucceed(
          authenticationSucceedType: _authenticationSucceedType));
  emitAuthenticationFailed() => emit(AuthenticationFailed());

  cancelSubscription() {
    _authenticationSubscription.cancel();
  }

  @override
  Future<void> close() {
    _authenticationSubscription.cancel();
    return super.close();
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return AuthenticationSucceed.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state is AuthenticationSucceed) return state.toMap();
  }
}
