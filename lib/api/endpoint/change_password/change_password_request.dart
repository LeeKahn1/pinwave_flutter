class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    "oldPassword": oldPassword,
    "newPassword": newPassword,
    "newPassword_confirmation": newPasswordConfirmation,
  };
}