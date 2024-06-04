import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/notification/list/notification_list_response.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationGetData>((event, emit) async {
      try {
        if (event.isLoading) {
          emit(NotificationGetDataLoading());
        }

        Response response = await ApiManager.getNotification();

        if (response.statusCode == 200) {
          NotificationListResponse notificationListResponse = NotificationListResponse.fromJson(response.data);

          emit(NotificationGetDataSuccess(notificationListResponse: notificationListResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(NotificationGetDataFinished());
      }
    });

    on<NotificationRealAll>((event, emit) async {
      try {
        emit(NotificationLoading());

        Response response = await ApiManager.putNotificationReadAll();

        if (response.statusCode == 200) {
          emit(NotificationRealAllSuccess());
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(NotificationFinished());
      }
    });

    on<NotificationReadById>((event, emit) async {
      try {
        emit(NotificationLoading());

        Response response = await ApiManager.putNotificationReadById(notificationId: event.notificationId);

        if (response.statusCode == 200) {
          emit(NotificationReadByIdSuccess());
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(NotificationFinished());
      }
    });
  }
}
