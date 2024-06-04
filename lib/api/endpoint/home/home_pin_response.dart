import 'package:tubes_pinwave/api/endpoint/home/home_pin_response_pin.dart';

class HomePinResponse {
  final List<HomePinResponsePin> pins;

  HomePinResponse({
    required this.pins,
  });

  factory HomePinResponse.fromJson(Map<String, dynamic> json) => HomePinResponse(
    pins: List<HomePinResponsePin>.from(json["pins"].map((x) => HomePinResponsePin.fromJson(x))),
  );
}
