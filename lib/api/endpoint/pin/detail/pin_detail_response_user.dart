class PinDetailResponseUser {
  final int id;
  final String username;
  final String? email;
  final String? imageUrl;
  final int followingCount;
  final bool followed;

  PinDetailResponseUser({
    required this.id,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.followingCount,
    required this.followed,
  });

  factory PinDetailResponseUser.fromJson(Map<String, dynamic> json) => PinDetailResponseUser(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    imageUrl: json["imageUrl"],
    followingCount: json["followingCount"],
    followed: json["followed"],
  );
}