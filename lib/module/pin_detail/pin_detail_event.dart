part of 'pin_detail_bloc.dart';

abstract class PinDetailEvent {}

class PinDetailGetData extends PinDetailEvent {
  final int pinId;

  PinDetailGetData({required this.pinId});
}

class PinDetailFollowUser extends PinDetailEvent {
  final int userId;

  PinDetailFollowUser({required this.userId});
}

class PinDetailLike extends PinDetailEvent {
  final int pinId;

  PinDetailLike({required this.pinId});
}

class PinDetailReport extends PinDetailEvent {
  final int pinId;
  final PinReportRequest pinReportRequest;

  PinDetailReport({required this.pinId, required this.pinReportRequest});
}

class PinDetailAddComment extends PinDetailEvent {
  final PinCommentRequest pinCommentRequest;

  PinDetailAddComment({required this.pinCommentRequest});
}

class PinDetailGetAlbumName extends PinDetailEvent {}

class PinDetailSaveToAlbum extends PinDetailEvent {
  final PinSaveToAlbumRequest pinSaveToAlbumRequest;

  PinDetailSaveToAlbum({required this.pinSaveToAlbumRequest});
}

class PinDetailDownload extends PinDetailEvent {
  final int pinId;

  PinDetailDownload({required this.pinId});
}


