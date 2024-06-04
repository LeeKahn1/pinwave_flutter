class AlbumNameRequest {
  final String name;

  AlbumNameRequest({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}