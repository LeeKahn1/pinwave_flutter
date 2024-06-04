import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/notification/notification_unread_response.dart';
import 'package:tubes_pinwave/constant.dart';
import 'package:tubes_pinwave/helper/preferences.dart';

part 'nav_menu_event.dart';
part 'nav_menu_state.dart';

class NavMenuBloc extends Bloc<NavMenuEvent, NavMenuState> {
  NavMenuBloc() : super(NavMenuInitial()) {
    on<NavMenuGetUnreadNotification>((event, emit) async {
      if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
        try {
          Response response = await ApiManager.getNotificationUnread();

          if (response.statusCode == 200) {
            NotificationUnreadResponse notificationUnreadResponse = NotificationUnreadResponse.fromJson(response.data);

            emit(NavMenuGetUnreadNotificationSuccess(notificationUnreadResponse: notificationUnreadResponse));
          }
        } catch (e) {
          print(e.toString());
        }
      }
    });
  }
}
