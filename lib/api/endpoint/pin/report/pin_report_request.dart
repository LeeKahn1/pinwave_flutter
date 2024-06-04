class PinReportRequest {
  final String reason;

  PinReportRequest({
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
    "reason": reason,
  };
}