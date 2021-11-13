part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSucceed extends AuthenticationState {
  final AuthenticationSucceedType authenticationSucceedType;
  const AuthenticationSucceed({
    required this.authenticationSucceedType,
  });

  @override
  List<Object> get props => [authenticationSucceedType];

  Map<String, dynamic> toMap() {
    return {
      'authenticationSucceedType': authenticationSucceedType.index,
    };
  }

  factory AuthenticationSucceed.fromMap(Map<String, dynamic> map) {
    return AuthenticationSucceed(
      authenticationSucceedType:
          AuthenticationSucceedType.values[map['authenticationSucceedType']],
    );
  }
}

class AuthenticationFailed extends AuthenticationState {}
