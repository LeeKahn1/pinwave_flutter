import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/edit_profile/edit_profile_request.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileClicked>((event, emit) async {
      try {
        emit(EditProfileClickedLoading());

        Response response = await ApiManager.postChangeProfile(editProfileRequest: event.editProfileRequest);

        if (response.statusCode == 200) {
          emit(EditProfileClickedSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(EditProfileClickedFinished());
      }
    });
  }
}
