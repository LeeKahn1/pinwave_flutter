import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/home/home_pin_response.dart';
import 'package:tubes_pinwave/helper/preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeGetData>((event, emit) async {
      try {
        emit(HomeGetDataLoading());

        Response response = await ApiManager.homePin();

        if (response.statusCode == 200) {
          HomePinResponse homePinResponse = HomePinResponse.fromJson(response.data);

          emit(HomeGetDataSuccess(homePinResponse: homePinResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(HomeGetDataFinished());
      }
    });
  }
}
