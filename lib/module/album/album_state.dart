part of 'album_bloc.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumGetDataLoading extends AlbumState {}

class AlbumGetDataSuccess extends AlbumState {
  final PinAlbumListResponse pinAlbumListResponse;

  AlbumGetDataSuccess({required this.pinAlbumListResponse});
}

class AlbumGetDataFinished extends AlbumState {}
