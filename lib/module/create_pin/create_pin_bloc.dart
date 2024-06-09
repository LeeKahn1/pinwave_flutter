import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response.dart';
import 'package:tubes_pinwave/api/endpoint/pin/create/pin_create_request.dart';

part 'create_pin_event.dart';
part 'create_pin_state.dart';

class CreatePinBloc extends Bloc<CreatePinEvent, CreatePinState> {
  CreatePinBloc() : super(CreatePinInitial()) {
    on<CreatePinPostData>((event, emit) async {
      try {
        emit(CreatePinPostDataLoading());

        Response response = await ApiManager.postCreatePin(pinCreateRequest: event.pinCreateRequest);

        if (response.statusCode == 201) {
          emit(CreatePinPostDataSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(CreatePinPostDataFinished());
      }
    });

    on<CreatePinGetAlbum>((event, emit) async {
      try {
        emit(CreatePinGetAlbumLoading());

        Response response = await ApiManager.getAlbumName();

        if (response.statusCode == 200) {
          AlbumNameResponse albumNameResponse = AlbumNameResponse.fromJson(response.data);

          emit(CreatePinGetAlbumSuccess(albumNameResponse: albumNameResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(CreatePinGetAlbumFinished());
      }
    });
  }
}
