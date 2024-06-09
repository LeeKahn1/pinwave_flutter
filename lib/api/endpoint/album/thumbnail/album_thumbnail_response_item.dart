class AlbumThumbnailResponseItem {
  final int id;
  final String name;
  final String? thumbnail;

  AlbumThumbnailResponseItem({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory AlbumThumbnailResponseItem.fromJson(Map<String, dynamic> json) => AlbumThumbnailResponseItem(
    id: json["id"],
    name: json["name"],
    thumbnail: json["thumbnail"],
  );
}