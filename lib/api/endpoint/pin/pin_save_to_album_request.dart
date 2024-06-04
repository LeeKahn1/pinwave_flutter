class PinSaveToAlbumRequest {
  final int albumId;
  final int pinId;

  PinSaveToAlbumRequest({
    required this.albumId,
    required this.pinId,
  });

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "pinId": pinId,
  };
}