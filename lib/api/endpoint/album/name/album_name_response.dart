import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response_item.dart';

class AlbumNameResponse {
  final List<AlbumNameResponseItem> albums;

  AlbumNameResponse({
    required this.albums,
  });

  factory AlbumNameResponse.fromJson(Map<String, dynamic> json) => AlbumNameResponse(
    albums: List<AlbumNameResponseItem>.from(json["albums"].map((x) => AlbumNameResponseItem.fromJson(x))),
  );
}