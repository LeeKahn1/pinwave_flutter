import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/sign_up/sign_up_request.dart';
import 'package:tubes_pinwave/constant.dart';
import 'package:tubes_pinwave/helper/preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpClicked>((event, emit) async {
      try {
        emit(SignUpClickedLoading());

        Response response = await ApiManager.signUp(signUpRequest: event.signUpRequest);

        if (response.statusCode == 201) {
          Preferences.getInstance().setString(SharedPreferenceKey.SESSION_ID, response.data['token']);
          Preferences.getInstance().setString(SharedPreferenceKey.USERNAME, response.data['user']['username']);

          emit(SignUpClickedSuccess());
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(SignUpClickedFinished());
      }
    });
  }
}
