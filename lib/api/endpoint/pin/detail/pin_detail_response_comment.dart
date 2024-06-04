class PinDetailResponseComment {
  final int id;
  final bool owned;
  final String content;
  final String username;
  final String imageUrl;

  PinDetailResponseComment({
    required this.id,
    required this.owned,
    required this.content,
    required this.username,
    required this.imageUrl,
  });

  factory PinDetailResponseComment.fromJson(Map<String, dynamic> json) => PinDetailResponseComment(
    id: json["id"],
    owned: json["owned"],
    content: json["content"],
    username: json["username"],
    imageUrl: json["imageUrl"],
  );
}