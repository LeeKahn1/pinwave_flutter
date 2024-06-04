import 'package:tubes_pinwave/api/endpoint/pin/search/pin_search_response_pin.dart';

class PinSearchResponse {
  final List<PinSearchResponsePin> pins;

  PinSearchResponse({
    required this.pins,
  });

  factory PinSearchResponse.fromJson(Map<String, dynamic> json) => PinSearchResponse(
    pins: List<PinSearchResponsePin>.from(json["pins"].map((x) => PinSearchResponsePin.fromJson(x))),
  );
}