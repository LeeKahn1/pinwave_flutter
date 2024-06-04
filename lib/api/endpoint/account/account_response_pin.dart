class AccountResponsePin {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String link;
  final String tag;
  final bool likes;

  AccountResponsePin({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.tag,
    required this.likes,
  });

  factory AccountResponsePin.fromJson(Map<String, dynamic> json) => AccountResponsePin(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    link: json["link"],
    tag: json["tag"],
    likes: json["likes"],
  );
}