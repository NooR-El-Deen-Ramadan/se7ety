class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthLoasdingState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState(this.message);
}
