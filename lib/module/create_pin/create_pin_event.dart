part of 'create_pin_bloc.dart';

abstract class CreatePinEvent {}

class CreatePinPostData extends CreatePinEvent {
  final PinCreateRequest pinCreateRequest;

  CreatePinPostData({required this.pinCreateRequest});
}

class CreatePinGetAlbum extends CreatePinEvent {}