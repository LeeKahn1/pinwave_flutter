part of 'album_bloc.dart';

abstract class AlbumEvent {}

class AlbumGetData extends AlbumEvent {
  final int albumId;

  AlbumGetData({required this.albumId});
}
