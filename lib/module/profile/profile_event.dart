part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileAccount extends ProfileEvent {}

class ProfileAlbumName extends ProfileEvent {}

class ProfileAddAlbumName extends ProfileEvent {
  final AlbumNameRequest albumNameRequest;

  ProfileAddAlbumName({required this.albumNameRequest});
}

class ProfileChangePassword extends ProfileEvent {
  final ChangePasswordRequest changePasswordRequest;

  ProfileChangePassword({required this.changePasswordRequest});
}

class ProfileLogout extends ProfileEvent {}


