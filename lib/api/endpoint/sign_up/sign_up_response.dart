import 'package:tubes_pinwave/api/endpoint/sign_up/sign_up_response_user.dart';

class SignUpResponse {
  final SignUpResponseUser user;
  final String token;

  SignUpResponse({
    required this.user,
    required this.token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    user: SignUpResponseUser.fromJson(json["user"]),
    token: json["token"],
  );
}