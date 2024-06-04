import 'package:tubes_pinwave/api/endpoint/album/thumbnail/album_thumbnail_response_item.dart';

class AlbumThumbnailResponse {
  final List<AlbumThumbnailResponseItem> albumThumbnails;

  AlbumThumbnailResponse({
    required this.albumThumbnails,
  });

  factory AlbumThumbnailResponse.fromJson(Map<String, dynamic> json) => AlbumThumbnailResponse(
    albumThumbnails: List<AlbumThumbnailResponseItem>.from(json["albumThumbnails"].map((x) => AlbumThumbnailResponseItem.fromJson(x))),
  );
}