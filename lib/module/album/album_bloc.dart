import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/pin/album_list/pin_album_list_response.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    on<AlbumGetData>((event, emit) async {
      try {
        emit(AlbumGetDataLoading());

        Response response = await ApiManager.getPinAlbum(albumId: event.albumId);

        if (response.statusCode == 200) {
          PinAlbumListResponse pinAlbumListResponse = PinAlbumListResponse.fromJson(response.data);

          emit(AlbumGetDataSuccess(pinAlbumListResponse: pinAlbumListResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(AlbumGetDataFinished());
      }
    });
  }
}
