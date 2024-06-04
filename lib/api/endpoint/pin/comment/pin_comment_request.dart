class PinCommentRequest {
  final int pinId;
  final String message;

  PinCommentRequest({
    required this.pinId,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    "pinId": pinId,
    "message": message,
  };
}