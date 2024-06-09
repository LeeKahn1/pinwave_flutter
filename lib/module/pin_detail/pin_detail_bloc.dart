import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response.dart';
import 'package:tubes_pinwave/api/endpoint/pin/comment/pin_comment_request.dart';
import 'package:tubes_pinwave/api/endpoint/pin/detail/pin_detail_response.dart';
import 'package:tubes_pinwave/api/endpoint/pin/pin_save_to_album_request.dart';
import 'package:tubes_pinwave/api/endpoint/pin/report/pin_report_request.dart';

part 'pin_detail_event.dart';
part 'pin_detail_state.dart';

class PinDetailBloc extends Bloc<PinDetailEvent, PinDetailState> {
  PinDetailBloc() : super(PinDetailInitial()) {
    on<PinDetailGetData>((event, emit) async {
      try {
        emit(PinDetailGetDataLoading());

        Response response = await ApiManager.getPinDetail(pinId: event.pinId);

        if (response.statusCode == 200) {
          PinDetailResponse pinDetailResponse = PinDetailResponse.fromJson(response.data);

          emit(PinDetailGetDataSuccess(pinDetailResponse: pinDetailResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailGetDataFinished());
      }
    });

    on<PinDetailFollowUser>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.putFollowUser(userId: event.userId);

        if (response.statusCode == 200) {
          emit(PinDetailFollowUserSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });

    on<PinDetailLike>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.putLikePin(pinId: event.pinId);

        if (response.statusCode == 200) {
          emit(PinDetailLikeSuccess(message: response.data.toString(),));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });

    on<PinDetailReport>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.putReportPin(pinId: event.pinId, pinReportRequest: event.pinReportRequest);

        if (response.statusCode == 200) {
          emit(PinDetailReportSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });

    on<PinDetailAddComment>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.postCreateComment(pinCommentRequest: event.pinCommentRequest,);

        if (response.statusCode == 200) {
          emit(PinDetailAddCommentSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });

    on<PinDetailGetAlbumName>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.getAlbumName();

        if (response.statusCode == 200) {
          AlbumNameResponse albumNameResponse = AlbumNameResponse.fromJson(response.data);

          emit(PinDetailGetAlbumNameSuccess(albumNameResponse: albumNameResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });

    on<PinDetailSaveToAlbum>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.pinSaveRemove(pinSaveToAlbumRequest: event.pinSaveToAlbumRequest);

        if (response.statusCode == 200) {
          emit(PinDetailSaveToAlbumSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });

    on<PinDetailDownload>((event, emit) async {
      try {
        emit(PinDetailLoading());

        Response response = await ApiManager.pinDownload(pinId: event.pinId,);

        if (response.statusCode == 200) {
          Uint8List uint8list = response.data;
          String filename = response.headers['Content-Name']![0];

          emit(PinDetailDownloadSuccess(
            uint8list: uint8list,
            filename: filename,
          ));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(PinDetailFinished());
      }
    });
  }
}
