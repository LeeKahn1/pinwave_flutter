part of 'edit_profile_bloc.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileClickedLoading extends EditProfileState {}

class EditProfileClickedSuccess extends EditProfileState {
  final String message;

  EditProfileClickedSuccess({required this.message});
}

class EditProfileClickedFinished extends EditProfileState {}
