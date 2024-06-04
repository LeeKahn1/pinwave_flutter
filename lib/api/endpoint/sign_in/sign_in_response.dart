class SignInResponse {
  final String phoneNumber;
  final String name;
  final String emailAddress;
  final String imageUrl;
  final bool isVerified;

  SignInResponse({
    required this.phoneNumber,
    required this.name,
    required this.emailAddress,
    required this.imageUrl,
    required this.isVerified,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
      phoneNumber: json["phoneNumber"] ?? "",
      name: json["name"] ?? "",
      emailAddress: json["emailAddress"] ?? "",
      imageUrl: json["imageUrl"] ?? "No Image",
      isVerified: json["isVerified"] ?? false,
  );
}