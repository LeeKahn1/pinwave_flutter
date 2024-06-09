class PinSearchResponseUser {
  final String username;
  final String email;
  final String? imageUrl;

  PinSearchResponseUser({
    required this.username,
    required this.email,
    required this.imageUrl,
  });

  factory PinSearchResponseUser.fromJson(Map<String, dynamic> json) => PinSearchResponseUser(
    username: json["username"],
    email: json["email"],
    imageUrl: json["imageUrl"],
  );
}