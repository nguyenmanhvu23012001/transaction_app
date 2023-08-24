import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:zen8app/core/core.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
  @JsonKey(name :"_id")
  final String id;
  final String username;
  final String password;
  @JsonKey(defaultValue: "daoxuanloc@gmail.com" )
  final String email;
  @JsonKey(name :"number_phone")
  final String numberPhone;
  @JsonKey(name :"deleted_at")
  final DateTime? deletedAt;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.numberPhone,
    this.deletedAt,
  });
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}