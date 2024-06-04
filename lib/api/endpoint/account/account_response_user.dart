class AccountResponseUser {
  final String username;
  final String email;
  final String imageUrl;
  final int pinsCount;
  final int likesCount;
  final int followersCount;

  AccountResponseUser({
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.pinsCount,
    required this.likesCount,
    required this.followersCount,
  });

  factory AccountResponseUser.fromJson(Map<String, dynamic> json) => AccountResponseUser(
    username: json["username"],
    email: json["email"],
    imageUrl: json["imageUrl"],
    pinsCount: json["pinsCount"],
    likesCount: json["likesCount"],
    followersCount: json["followersCount"],
  );
}