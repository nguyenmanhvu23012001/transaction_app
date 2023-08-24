
import 'package:json_annotation/json_annotation.dart';

part 'user_infor.g.dart';

@JsonSerializable()
class UserInfo {
  String name;
  String role;
  String email;
  @JsonKey(name: "number_phone")
  String phoneNumber;

  UserInfo({
    required this.name,
    required this.role,
    required this.email,
    required this.phoneNumber,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}