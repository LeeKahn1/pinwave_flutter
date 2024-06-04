part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class NotificationGetData extends NotificationEvent {
  final bool isLoading;

  NotificationGetData({this.isLoading = true});
}

class NotificationRealAll extends NotificationEvent {}

class NotificationReadById extends NotificationEvent {
  final String notificationId;

  NotificationReadById({required this.notificationId});
}
