class AlbumNameResponseItem {
  final int id;
  final String name;

  AlbumNameResponseItem({
    required this.id,
    required this.name,
  });

  factory AlbumNameResponseItem.fromJson(Map<String, dynamic> json) => AlbumNameResponseItem(
    id: json["id"],
    name: json["name"],
  );
}