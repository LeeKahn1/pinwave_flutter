import 'package:tubes_pinwave/api/endpoint/comment/comment_response_item.dart';

class CommentResponse {
  final List<CommentResponseItem> comments;

  CommentResponse({
    required this.comments,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) => CommentResponse(
    comments: List<CommentResponseItem>.from(json["comments"].map((x) => CommentResponseItem.fromJson(x))),
  );
}