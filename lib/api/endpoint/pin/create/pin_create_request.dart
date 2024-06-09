class PinCreateRequest {
  final String title;
  final String? description;
  final String imagePath;
  final String? link;
  final String? tags;
  final int? albumId;

  PinCreateRequest({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.link,
    required this.tags,
    required this.albumId,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "image": imagePath,
    "link": link,
    "tags": tags,
    "albumId": albumId,
  };
}