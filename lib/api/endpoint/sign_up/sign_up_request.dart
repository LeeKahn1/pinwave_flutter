class SignUpRequest {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;

  SignUpRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
