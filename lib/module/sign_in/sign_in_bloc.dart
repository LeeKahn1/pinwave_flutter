import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/sign_in/sign_in_request.dart';
import 'package:tubes_pinwave/constant.dart';
import 'package:tubes_pinwave/helper/preferences.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInClick>((event, emit) async {
      try {
        emit(SignInClickedLoading());

        Response response = await ApiManager.signIn(signInRequest: event.signInRequest);

        if (response.statusCode == 200) {
          Preferences.getInstance().setString(SharedPreferenceKey.SESSION_ID, response.data['tokens']['token']);
          Preferences.getInstance().setString(SharedPreferenceKey.USERNAME, response.data['tokens']['name']);

          emit(SignInClickedSuccess());
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(SignInClickedFinished());
      }
    });
  }
}
