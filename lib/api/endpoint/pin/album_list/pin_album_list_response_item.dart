class PinAlbumListResponseItem {
  final int id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? link;
  final String? tags;

  PinAlbumListResponseItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.tags,
  });

  factory PinAlbumListResponseItem.fromJson(Map<String, dynamic> json) => PinAlbumListResponseItem(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    link: json["link"],
    tags: json["tags"],
  );
}