class NotificationUnreadResponse {
  final int unread;

  NotificationUnreadResponse({
    required this.unread,
  });

  factory NotificationUnreadResponse.fromJson(Map<String, dynamic> json) => NotificationUnreadResponse(
    unread: json["unread"],
  );
}