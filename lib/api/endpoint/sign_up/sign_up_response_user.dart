class SignUpResponseUser {
  final String username;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  SignUpResponseUser({
    required this.username,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory SignUpResponseUser.fromJson(Map<String, dynamic> json) => SignUpResponseUser(
    username: json["username"],
    email: json["email"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );
}