import 'package:tubes_pinwave/api/endpoint/pin/detail/pin_detail_response_item.dart';

class PinDetailResponse {
  final PinDetailResponseItem pins;

  PinDetailResponse({
    required this.pins,
  });

  factory PinDetailResponse.fromJson(Map<String, dynamic> json) => PinDetailResponse(
    pins: PinDetailResponseItem.fromJson(json["pins"]),
  );
}