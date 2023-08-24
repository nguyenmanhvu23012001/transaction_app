// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData(
      id: json['_id'] as String,
      buyer: User.fromJson(json['buyer'] as Map<String, dynamic>),
      seller: User.fromJson(json['seller'] as Map<String, dynamic>),
      goods: json['goods'] as String,
      transactionMoney: (json['transaction_money'] as num).toDouble(),
      deposit: (json['deposit'] as num).toDouble(),
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'buyer': instance.buyer,
      'seller': instance.seller,
      'goods': instance.goods,
      'transaction_money': instance.transactionMoney,
      'deposit': instance.deposit,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
