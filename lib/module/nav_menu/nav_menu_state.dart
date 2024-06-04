part of 'nav_menu_bloc.dart';

abstract class NavMenuState {}

class NavMenuInitial extends NavMenuState {}

class NavMenuGetUnreadNotificationSuccess extends NavMenuState {
  final NotificationUnreadResponse notificationUnreadResponse;

  NavMenuGetUnreadNotificationSuccess({required this.notificationUnreadResponse});
}
