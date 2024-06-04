import 'package:tubes_pinwave/api/endpoint/account/account_response_pin.dart';
import 'package:tubes_pinwave/api/endpoint/account/account_response_user.dart';

class AccountResponse {
  final AccountResponseUser user;
  final List<AccountResponsePin> pins;

  AccountResponse({
    required this.user,
    required this.pins,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
    user: AccountResponseUser.fromJson(json["user"]),
    pins: List<AccountResponsePin>.from(json["pins"].map((x) => AccountResponsePin.fromJson(x))),
  );
}