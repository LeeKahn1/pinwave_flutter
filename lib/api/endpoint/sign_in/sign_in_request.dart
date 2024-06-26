class SignInRequest {
  final String username;
  final String password;

  SignInRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => <String, dynamic> {
    'username': username,
    'password': password,
  };
}