class EditProfileRequest {
  final String? imagePath;
  final String username;
  final String email;

  EditProfileRequest({
    required this.imagePath,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "photo": imagePath,
    "username": username,
    "email": email,
  };
}