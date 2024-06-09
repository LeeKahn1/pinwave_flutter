part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFinished extends ProfileState {}

class ProfileAccountLoading extends ProfileState {}

class ProfileAccountSuccess extends ProfileState {
  final AccountResponse accountResponse;
  final AlbumThumbnailResponse albumThumbnailResponse;

  ProfileAccountSuccess({required this.accountResponse, required this.albumThumbnailResponse});
}

class ProfileAccountFinished extends ProfileState {}

class ProfileAlbumNameSuccess extends ProfileState {
  final AlbumNameResponse albumNameResponse;

  ProfileAlbumNameSuccess({required this.albumNameResponse});
}

class ProfileAddAlbumNameSuccess extends ProfileState {}

class ProfileChangePasswordSuccess extends ProfileState {
  final String message;

  ProfileChangePasswordSuccess({required this.message});
}

class ProfileLogoutSuccess extends ProfileState {}

