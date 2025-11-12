import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';

class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthSuccessState extends AuthStates {
   final UserTypeEnum userType;
  AuthSuccessState(this.userType);
}

class AuthLoadingState extends AuthStates {
 
}

class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState(this.message);
}
