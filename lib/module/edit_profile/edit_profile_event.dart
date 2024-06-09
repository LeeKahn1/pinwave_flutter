part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class EditProfileClicked extends EditProfileEvent {
  final EditProfileRequest editProfileRequest;

  EditProfileClicked({required this.editProfileRequest});
}