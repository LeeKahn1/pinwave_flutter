part of 'pin_detail_bloc.dart';

abstract class PinDetailState {}

class PinDetailInitial extends PinDetailState {}

class PinDetailGetDataLoading extends PinDetailState {}

class PinDetailGetDataSuccess extends PinDetailState {
  final PinDetailResponse pinDetailResponse;

  PinDetailGetDataSuccess({required this.pinDetailResponse});
}

class PinDetailGetDataFinished extends PinDetailState {}

class PinDetailLoading extends PinDetailState {}

class PinDetailFinished extends PinDetailState {}

class PinDetailFollowUserSuccess extends PinDetailState {
  final String message;

  PinDetailFollowUserSuccess({required this.message});
}

class PinDetailLikeSuccess extends PinDetailState {
  final String message;

  PinDetailLikeSuccess({required this.message});
}

class PinDetailReportSuccess extends PinDetailState {
  final String message;

  PinDetailReportSuccess({required this.message});
}

class PinDetailAddCommentSuccess extends PinDetailState {
  final String message;

  PinDetailAddCommentSuccess({required this.message});
}

class PinDetailGetAlbumNameSuccess extends PinDetailState {
  final AlbumNameResponse albumNameResponse;

  PinDetailGetAlbumNameSuccess({required this.albumNameResponse});
}

class PinDetailSaveToAlbumSuccess extends PinDetailState {
  final String message;

  PinDetailSaveToAlbumSuccess({required this.message});
}

class PinDetailDownloadSuccess extends PinDetailState {
  final Uint8List uint8list;
  final String filename;

  PinDetailDownloadSuccess({required this.uint8list, required this.filename});
}
