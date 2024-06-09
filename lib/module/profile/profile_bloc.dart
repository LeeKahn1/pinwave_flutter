import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tubes_pinwave/api/api_manager.dart';
import 'package:tubes_pinwave/api/endpoint/account/account_response.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_request.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response.dart';
import 'package:tubes_pinwave/api/endpoint/album/thumbnail/album_thumbnail_response.dart';
import 'package:tubes_pinwave/api/endpoint/change_password/change_password_request.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileAccount>((event, emit) async {
      try {
        emit(ProfileAccountLoading());

        Response responseAccount = await ApiManager.getAccount();

        if (responseAccount.statusCode == 200) {
          AccountResponse accountResponse = AccountResponse.fromJson(responseAccount.data);

          Response responseAlbumThumbnail = await ApiManager.getAlbumThumbnail();

          if (responseAlbumThumbnail.statusCode == 200) {
            AlbumThumbnailResponse albumThumbnailResponse = AlbumThumbnailResponse.fromJson(responseAlbumThumbnail.data);

            emit(ProfileAccountSuccess(
              accountResponse: accountResponse,
              albumThumbnailResponse: albumThumbnailResponse,
            ));
          }
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(ProfileAccountFinished());
      }
    });

    on<ProfileAlbumName>((event, emit) async {
      try {
        emit(ProfileLoading());

        Response response = await ApiManager.getAlbumName();

        if (response.statusCode == 200) {
          AlbumNameResponse albumNameResponse = AlbumNameResponse.fromJson(response.data);


          emit(ProfileAlbumNameSuccess(albumNameResponse: albumNameResponse));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(ProfileFinished());
      }
    });

    on<ProfileAddAlbumName>((event, emit) async {
      try {
        emit(ProfileLoading());

        Response response = await ApiManager.postAlbumName(albumNameRequest: event.albumNameRequest);

        if (response.statusCode == 200) {
          emit(ProfileAddAlbumNameSuccess());
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(ProfileFinished());
      }
    });

    on<ProfileChangePassword>((event, emit) async {
      try {
        emit(ProfileLoading());

        Response response = await ApiManager.putChangePassword(changePasswordRequest: event.changePasswordRequest);

        if (response.statusCode == 200) {
          emit(ProfileChangePasswordSuccess(message: response.data.toString()));
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(ProfileFinished());
      }
    });

    on<ProfileLogout>((event, emit) async {
      try {
        emit(ProfileLoading());

        Response response = await ApiManager.signOut();

        if (response.statusCode == 200) {
          emit(ProfileLogoutSuccess());
        }
      } catch (e) {
        print(e.toString());
      } finally {
        emit(ProfileFinished());
      }
    });
  }
}
