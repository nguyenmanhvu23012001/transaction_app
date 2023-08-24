import 'package:json_annotation/json_annotation.dart';
import 'package:zen8app/models/sources/user_infor.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserInfo userInfo;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userInfo,
  });


  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
