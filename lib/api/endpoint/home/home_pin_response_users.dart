class HomePinResponseUsers {
  final String username;
  final String email;
  final String imageUrl;

  HomePinResponseUsers({
    required this.username,
    required this.email,
    required this.imageUrl,
  });

  factory HomePinResponseUsers.fromJson(Map<String, dynamic> json) => HomePinResponseUsers(
    username: json["username"],
    email: json["email"],
    imageUrl: json["imageUrl"],
  );
}