import 'package:tubes_pinwave/api/endpoint/pin/album_list/pin_album_list_response_item.dart';

class PinAlbumListResponse {
  final List<PinAlbumListResponseItem> pinAlbumPhotos;

  PinAlbumListResponse({
    required this.pinAlbumPhotos,
  });

  factory PinAlbumListResponse.fromJson(Map<String, dynamic> json) => PinAlbumListResponse(
    pinAlbumPhotos: List<PinAlbumListResponseItem>.from(json["pinAlbumPhotos"].map((x) => PinAlbumListResponseItem.fromJson(x))),
  );
}