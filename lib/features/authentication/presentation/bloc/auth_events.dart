class AuthEvents {}

class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvents {
  final String email;
  final String password;
  final String username;

  RegisterEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}
