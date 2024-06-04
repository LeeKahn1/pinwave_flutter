import 'package:tubes_pinwave/api/endpoint/notification/list/notification_list_response_item.dart';

class NotificationListResponse {
  final List<NotificationListResponseItem> notifications;

  NotificationListResponse({
    required this.notifications,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) => NotificationListResponse(
    notifications: List<NotificationListResponseItem>.from(json["notifications"].map((x) => NotificationListResponseItem.fromJson(x))),
  );
}