class NotificationListResponseItem {
  final String id;
  final String message;
  final DateTime? readAt;
  final DateTime? createdAt;

  NotificationListResponseItem({
    required this.id,
    required this.message,
    required this.readAt,
    required this.createdAt,
  });

  factory NotificationListResponseItem.fromJson(Map<String, dynamic> json) => NotificationListResponseItem(
    id: json["id"],
    message: json["message"],
    readAt: json["readAt"] != null ? DateTime.parse(json["readAt"]) : null,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
  );
}