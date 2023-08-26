// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      deposit: json['deposit'] as int,
      debit: json['debit'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'deposit': instance.deposit,
      'debit': instance.debit,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
