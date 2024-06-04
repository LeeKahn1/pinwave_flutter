import 'package:tubes_pinwave/api/endpoint/home/home_pin_response_users.dart';

class HomePinResponsePin {
  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? link;
  final String? tags;
  final bool liked;
  final HomePinResponseUsers users;

  HomePinResponsePin({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.tags,
    required this.liked,
    required this.users,
  });

  factory HomePinResponsePin.fromJson(Map<String, dynamic> json) => HomePinResponsePin(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    link: json["link"],
    tags: json["tags"],
    liked: json["liked"],
    users: HomePinResponseUsers.fromJson(json["users"]),
  );
}
