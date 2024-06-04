part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationGetDataLoading extends NotificationState {}

class NotificationGetDataSuccess extends NotificationState {
  final NotificationListResponse notificationListResponse;

  NotificationGetDataSuccess({required this.notificationListResponse});
}

class NotificationGetDataFinished extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationFinished extends NotificationState {}

class NotificationRealAllSuccess extends NotificationState {}

class NotificationReadByIdSuccess extends NotificationState {}


