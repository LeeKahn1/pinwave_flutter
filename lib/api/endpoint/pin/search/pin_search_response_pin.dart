import 'package:tubes_pinwave/api/endpoint/pin/search/pin_search_response_user.dart';

class PinSearchResponsePin {
  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? link;
  final String? tags;
  final bool liked;
  final PinSearchResponseUser users;

  PinSearchResponsePin({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.tags,
    required this.liked,
    required this.users,
  });

  factory PinSearchResponsePin.fromJson(Map<String, dynamic> json) => PinSearchResponsePin(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    link: json["link"],
    tags: json["tags"],
    liked: json["liked"],
    users: PinSearchResponseUser.fromJson(json["users"]),
  );
}