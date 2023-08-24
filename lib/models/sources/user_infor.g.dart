// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      phoneNumber: json['number_phone'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'number_phone': instance.phoneNumber,
    };
