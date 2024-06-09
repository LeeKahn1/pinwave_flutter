part of 'create_pin_bloc.dart';

abstract class CreatePinState {}

class CreatePinInitial extends CreatePinState {}

class CreatePinPostDataLoading extends CreatePinState {}

class CreatePinPostDataSuccess extends CreatePinState {
  final String message;

  CreatePinPostDataSuccess({required this.message});
}

class CreatePinPostDataFinished extends CreatePinState {}

class CreatePinGetAlbumLoading extends CreatePinState {}

class CreatePinGetAlbumSuccess extends CreatePinState {
  final AlbumNameResponse albumNameResponse;

  CreatePinGetAlbumSuccess({required this.albumNameResponse});
}

class CreatePinGetAlbumFinished extends CreatePinState {}
