import 'package:tubes_pinwave/api/endpoint/pin/detail/pin_detail_response_comment.dart';
import 'package:tubes_pinwave/api/endpoint/pin/detail/pin_detail_response_user.dart';

class PinDetailResponse {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final dynamic link;
  final String tags;
  final bool liked;
  final bool owned;
  final int likesCount;
  final bool reported;
  final PinDetailResponseUser users;
  final List<PinDetailResponseComment> comments;

  PinDetailResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.tags,
    required this.liked,
    required this.owned,
    required this.likesCount,
    required this.reported,
    required this.users,
    required this.comments,
  });

  factory PinDetailResponse.fromJson(Map<String, dynamic> json) => PinDetailResponse(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    link: json["link"],
    tags: json["tags"],
    liked: json["liked"],
    owned: json["owned"],
    likesCount: json["likesCount"],
    reported: json["reported"],
    users: PinDetailResponseUser.fromJson(json["users"]),
    comments: List<PinDetailResponseComment>.from(json["comments"].map((x) => PinDetailResponseComment.fromJson(x))),
  );
}