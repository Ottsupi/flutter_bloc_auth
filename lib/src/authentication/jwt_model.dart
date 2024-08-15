final class JwtModel {
  final String access;
  final String refresh;

  JwtModel({
    required this.access,
    required this.refresh,
  });

  factory JwtModel.fromJson(Map<String, dynamic> json) {
    return JwtModel(
      access: json['access'],
      refresh: json['refresh'],
    );
  }
}
