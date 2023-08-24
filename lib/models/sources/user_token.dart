import 'package:json_annotation/json_annotation.dart';
import 'package:zen8app/models/sources/user_infor.dart';
part 'user_token.g.dart';

@JsonSerializable()
class UserToken {
  String accessToken;
  String refreshToken;
  UserInfo userInfo;

  UserToken({
    required this.accessToken,
    required this.refreshToken,
    required this.userInfo,
  });


  factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);
  Map<String, dynamic> toJson() => _$UserTokenToJson(this);
}

