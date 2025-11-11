import 'package:se7ety/features/authentication/data/models/user_type_enum.dart';

class AuthEvents {}

class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvents {
   final UserTypeEnum userType;
  final String email;
  final String password;
  final String username;

  RegisterEvent({
    required this. userType,
    required this.email,
    required this.password,
    required this.username,
  });
}
